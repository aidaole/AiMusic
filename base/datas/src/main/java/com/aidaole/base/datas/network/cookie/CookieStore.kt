package com.aidaole.base.datas.network.cookie

import okhttp3.Cookie
import okhttp3.HttpUrl

interface CookieStore {

    fun add(httpUrl: HttpUrl, cookie: Cookie)

    fun add(httpUrl: HttpUrl, cookies: List<Cookie>)

    fun get(httpUrl: HttpUrl): List<Cookie>

    fun getCookies(): List<Cookie>

    fun remove(httpUrl: HttpUrl, cookie: Cookie)

    fun remoteAll(): Boolean
}