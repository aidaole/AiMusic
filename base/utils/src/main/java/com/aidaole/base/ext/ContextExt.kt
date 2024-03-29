package com.aidaole.base.ext

import android.content.Context

class ContextExt

fun Context.getStatusBarHeight(): Int {
    var height = 0
    val resourceId = this.resources.getIdentifier("status_bar_height", "dimen", "android")
    height = if (resourceId > 0) {
        this.resources.getDimensionPixelSize(resourceId)
    } else {
        30.dp
    }
    return height
}