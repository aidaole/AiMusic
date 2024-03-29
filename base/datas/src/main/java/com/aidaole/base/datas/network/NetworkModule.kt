package com.aidaole.base.datas.network

import android.content.Context
import com.aidaole.base.datas.network.cookie.CookieJarImpl
import com.aidaole.base.datas.network.retrofit.calladapter.RespCallAdapterFactory
import com.aidaole.base.datas.network.retrofit.converter.StringConverterFactory
import com.google.gson.Gson
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import okhttp3.*
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {

    private const val TAG = "NetworkModule"

    @Provides
    fun provideNeteaseApi(retrofit: Retrofit): RetrofitNeteaseApi {
        return retrofit.create(RetrofitNeteaseApi::class.java)
    }

    @Provides
    fun provideRetrofit(client: OkHttpClient): Retrofit {
        return Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(StringConverterFactory())
            .addConverterFactory(GsonConverterFactory.create())
            .addCallAdapterFactory(RespCallAdapterFactory.create())
            .client(client)
            .build()
    }

    @Singleton
    @Provides
    fun provideOkhttpClient(
        @ApplicationContext context: Context
    ): OkHttpClient {
        return OkHttpClient.Builder()
            .addInterceptor(timestampInterceptor())
            .addInterceptor(HttpLoggingInterceptor().apply {
                level = HttpLoggingInterceptor.Level.BASIC
            })
            .cookieJar(CookieJarImpl(context))
            .build()
    }

    private fun timestampInterceptor(): Interceptor {
        return Interceptor { chain ->
            val oldRequest = chain.request()
            val newUrl = oldRequest.url.newBuilder()
                .addQueryParameter("timestamp", "${System.currentTimeMillis()}")
                .build()
            val newRequest = oldRequest.newBuilder()
                .url(newUrl)
                .build()
            chain.proceed(newRequest)
        }
    }

    @Provides
    fun provideGson(): Gson {
        return Gson()
    }
}