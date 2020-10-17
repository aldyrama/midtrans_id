package com.midtrans.midtrans_id

import androidx.annotation.NonNull;
import com.midtrans.sdk.corekit.models.snap.TransactionResult

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** MidtransIdPlugin */
class MidtransIdPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "midtrans_id")
      channel.setMethodCallHandler(MidtransIdPlugin().apply {
        delegate.activity = registrar.activity()
        delegate.channel = channel
      })
    }
  }

  private lateinit var channel : MethodChannel
  private val delegate = MidtransPluginDelegate()

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "midtrans_id")
    channel.setMethodCallHandler(this);
    delegate.channel = channel
  }

  override fun onMethodCall(call: MethodCall, result: Result) = delegate.handleMethodCall(call, result)

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    delegate.activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

  override fun onDetachedFromActivity() {}

}
