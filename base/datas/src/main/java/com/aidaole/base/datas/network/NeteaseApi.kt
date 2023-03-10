package com.aidaole.base.datas.network

import android.content.Context
import com.aidaole.base.datas.entities.*

interface NeteaseApi {

    fun getQrImg(): QrCheckParams?

    fun getQrScannedCode(qrKey: String): RespCheckLoginQr?

    fun getUserInfo(context: Context): RespUserInfo?

    fun loadTopPlayList(): RespPlayList?

    fun loadHotPlaylistTags(): HotPlayListTags?

    fun getPlaylistSongs(playlistId: Long): PlayListSongs?

    fun loadTopPlaylistSongs(): PlayListSongs?
}