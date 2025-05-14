var exec = cordova.require('cordova/exec');    

module.exports = {
    fetchAttributionData: function() {
        return new Promise((resolve, reject) => {
            exec(resolve, reject, 'SearchAds', 'fetchAttributionData');
        });
    }
}
