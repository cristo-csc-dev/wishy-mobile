package com.wishysa.wishy

import android.os.Bundle
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class MainActivity : FlutterActivity() {

    companion object {
        var formerActivity: MainActivity? = null
    }

    private val CHANNEL = "com.wishysa.wishy/channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("MainActivity", "onCreate")
        Log.d("MainActivity", intent.toString())
        if(formerActivity != null) {
            formerActivity?.finish()
        }
        formerActivity = this
    }

    override fun onResume() {
        super.onResume()
        val sharedLinkInfo: MutableMap<String, String> = HashMap()
        sharedLinkInfo.put("link", intent.getStringExtra(android.content.Intent.EXTRA_TEXT) ?: "")
        sharedLinkInfo.put("title", intent.getStringExtra(android.content.Intent.EXTRA_TITLE) ?: "")
        sharedLinkInfo.put("subject", intent.getStringExtra(android.content.Intent.EXTRA_SUBJECT) ?: "")

        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger -> {}
            MethodChannel(messenger, CHANNEL).invokeMethod("onSharedText", JSONObject(sharedLinkInfo as Map<*, *>?).toString())
        }

//        intent.getStringExtra(android.content.Intent.EXTRA_TEXT)?.let { shared ->
//            flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
//                MethodChannel(messenger, CHANNEL).invokeMethod("onSharedText", shared)
//            }
//            ShareIntentHandler.lastSharedText = null
//        }
    }
}
