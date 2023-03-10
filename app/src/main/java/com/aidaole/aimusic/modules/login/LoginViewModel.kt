package com.aidaole.aimusic.modules.login

import android.graphics.Bitmap
import androidx.core.graphics.drawable.toBitmap
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.aidaole.aimusic.App
import com.aidaole.aimusic.R
import com.aidaole.base.datas.StateValue
import com.aidaole.base.datas.entities.QrCheckParams
import com.aidaole.base.datas.network.NeteaseApi
import com.aidaole.base.utils.base64toBitmap
import com.aidaole.base.utils.logd
import com.aidaole.base.utils.logi
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import javax.inject.Inject

@HiltViewModel
class LoginViewModel @Inject constructor(
    private val neteaseApi: NeteaseApi
) : ViewModel() {

    companion object {
        private const val TAG = "LoginViewModel"
        private const val STATE_FAIL = -1

        private const val QR_FAILED_800 = 800
        private const val QR_SUCC_803 = 803
    }


    private val defaultQrBitmap =
        App.getContext().resources.getDrawable(R.mipmap.ic_launcher).toBitmap(200, 200)
    private val _qrImgBitmap = MutableLiveData(StateValue(defaultQrBitmap))
    val qrImgBitmap = _qrImgBitmap as LiveData<StateValue<Bitmap>>

    private var qrCheckParams: QrCheckParams? = null
    val finalQrLoginState = MutableLiveData(StateValue<Int>())

    fun refreshQr() {
        viewModelScope.launch {
            val qrParams = withContext(Dispatchers.IO) {
                return@withContext neteaseApi.getQrImg()
            }
            qrCheckParams = qrParams
            qrCheckParams?.let { it ->
                StateValue.Succ<Bitmap>()
                "refreshQr-> result: $it".logd(TAG, true)
                it.base64Img.base64toBitmap()?.let {
                    _qrImgBitmap.value = StateValue.Succ(it)
                } ?: run {
                    _qrImgBitmap.value = StateValue.Fail(null)
                }
            }
        }
    }

    fun checkQrScanned() {
        viewModelScope.launch {
            qrCheckParams?.let {
                withContext(Dispatchers.IO) {
                    var checkTimes = 10
                    while (checkTimes > 0) {
                        val scanReps =
                            neteaseApi.getQrScannedCode(it.keyCode) ?: return@withContext STATE_FAIL
                        val code = scanReps.code
                        "checkQrScaned-> code: $code".logi(TAG)
                        when (code) {
                            803 -> {
                                // ??????
                                finalQrLoginState.postValue(StateValue.Succ(QR_SUCC_803))
                                break
                            }
                            800 -> {
                                // ?????????????????????
                                finalQrLoginState.postValue(StateValue.Fail(QR_FAILED_800))
                                break
                            }
                            801, 802 -> {
                                // ?????????????????????
                                delay(5 * 1000)
                            }
                            else -> {
                                "checkQrScanned-> code: $code".logi(TAG)
                                finalQrLoginState.postValue(StateValue.Fail(code))
                                break
                            }
                        }
                        checkTimes--
                    }
                }
            } ?: run {
                "checkQrScanned-> qrCheckParams:$qrCheckParams".logi(TAG)
                finalQrLoginState.value = StateValue.Fail(-1)
            }
        }
    }
}