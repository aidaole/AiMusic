package com.aidaole.aimusic.modules.playlist

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.navigation.fragment.findNavController
import com.aidaole.aimusic.R
import com.aidaole.aimusic.databinding.FragmentPlaylistBinding
import com.aidaole.base.datas.UserInfoManager
import com.aidaole.base.utils.logi
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class PlaylistFragment : Fragment() {
    companion object {
        private const val TAG = "PlaylistFragment"
    }

    private val playlistVM: PlaylistViewModel by viewModels()
    private val layout by lazy { FragmentPlaylistBinding.inflate(layoutInflater) }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        return layout.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val userinfo = UserInfoManager.getUserInfo(requireContext())
        "onViewCreated-> $userinfo".logi(TAG)
        if (userinfo == null) {
            findNavController().navigate(R.id.action_playlistFragment_to_loginFragment)
            return
        }
        layout.nickname.text = userinfo.profile.nickname
    }
}