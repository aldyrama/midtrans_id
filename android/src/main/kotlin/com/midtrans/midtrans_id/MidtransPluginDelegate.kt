package com.midtrans.midtrans_id

import android.app.Activity
import android.widget.Toast
import com.midtrans.sdk.corekit.callback.TransactionFinishedCallback
import com.midtrans.sdk.corekit.core.MidtransSDK
import com.midtrans.sdk.corekit.models.UserAddress
import com.midtrans.sdk.corekit.models.UserDetail
import com.midtrans.sdk.corekit.models.snap.TransactionResult
import com.midtrans.sdk.uikit.SdkUIFlowBuilder
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result


class MidtransPluginDelegate: TransactionFinishedCallback {

    var activity: Activity? = null
    lateinit var channel : MethodChannel

    private fun initSdk(clientKey: String?, merchantUrl: String?){
        SdkUIFlowBuilder.init()
                .setClientKey(clientKey) // mandatory
                .setContext(activity)
                .setTransactionFinishedCallback(this)
                .setMerchantBaseUrl(merchantUrl) // mandatory
                .enableLog(true)
                .buildSDK()
    }

    private fun initUser(fullName: String, email: String, phonNumber: String, userId: String){
        val userDetail = UserDetail()
        userDetail.userFullName = fullName
        userDetail.email = email
        userDetail.phoneNumber = phonNumber
        userDetail.userId = userId
    }

    private fun initUserAddress(userAddresses: ArrayList<UserAddress>){
        val addresses: ArrayList<UserAddress> = ArrayList()

    }

    private fun doPayment(args: String?){

    }

    private fun doPaymentWithToken(token: String?){
        MidtransSDK.getInstance().uiKitCustomSetting.isSkipCustomerDetailsPages = true
        MidtransSDK.getInstance().startPaymentUiFlow(activity, token)
    }

    fun handleMethodCall(call: MethodCall, result: Result) {
        if (call.method == "init"){
            initSdk(call.argument("clientKey"), call.argument("merchantUrl"))
        } else if (call.method == "doPayment"){
            doPayment(call.arguments())
        } else if (call.method == "doPaymentWithToken"){
            doPaymentWithToken(call.argument("token"))
        } else if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }

    override fun onTransactionFinished(result: TransactionResult?) {
        Toast.makeText(activity, result.toString(), Toast.LENGTH_LONG).show()
        val data: HashMap<String, Any> = HashMap()
        if (result != null){
            data["transactionCanceled"] = result.isTransactionCanceled
            data["status"] = result.status
            data["source"] = result.source
            data["statusMessage"] = result.statusMessage
            data["deeplinkUrl"] = result.response.deeplinkUrl

            if (result.response != null){
                data["response"] = result.response
            }else{
                data["response"] = ""
            }
//            channel.invokeMethod("onTransactionFinished", data);
        }

    }

}