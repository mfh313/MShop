require("NSURL, UIApplication");

defineClass("EPLoginViewController", {
    onClickLoginBtn: function(sender) {
        self.view().endEditing(YES);
        self.showTips("即将自动下载最新版本,请点击确认");
        var loadUrl = NSURL.URLWithString("itms-services://?action=download-manifest&url=https://www.eeka.info/eekapos_test/eekapos.plist");
        UIApplication.sharedApplication().performSelector_withObject_afterDelay("openURL:", loadUrl, 1.5);
    }
}, {});