package com.wishysa.wishy

import android.app.Activity
import android.content.Intent
import android.os.Bundle

class ShareReceiverActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//
//        val sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
//
//        if (sharedText != null) {
//            // Guardar el texto recibido en una variable global o pasarlo por un Broadcast
//            ShareIntentHandler.lastSharedText = sharedText
//        }
//
//        // Lanzar o traer al frente la actividad Flutter principal
//        val mainIntent = Intent(this, MainActivity::class.java).apply {
//            addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP)
//        }
//        startActivity(mainIntent)
//
//        finish() // Cerramos esta actividad puente
    }
}
