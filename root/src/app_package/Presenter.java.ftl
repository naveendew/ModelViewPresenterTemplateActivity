package ${packageName};


import android.app.Activity;
import android.support.annotation.Nullable;

import com.google.gson.Gson;
import com.google.gson.JsonParseException;
import com.pratilipi.mobile.android.AppSingeltonData;
import com.pratilipi.mobile.android.R;
import com.pratilipi.mobile.android.StaticConstants;
import com.pratilipi.mobile.android.clevertap.CleverTapConstants;
import com.pratilipi.mobile.android.clevertap.CleverTapEventUtil;
import com.pratilipi.mobile.android.util.HttpUtil;
import com.pratilipi.mobile.android.util.Log;

import org.json.JSONObject;
import java.util.HashMap;


public class ${className}Presenter implements ${className}Contract.UserActionListener{

    private static final String TAG = ${className}Presenter.class.getSimpleName();

    private Activity mActivityContext;
    private ${className}Contract.View mView;
    

    ${className}Presenter(Activity mActivityContext, ${className}Contract.View mView) {
        this.mActivityContext = mActivityContext;
        this.mView = mView;
    }


    @Override
    public void getDatafromServer() {
        //request params
        HashMap<String, String> reqParams = new HashMap<>();
        //reqParams.put(StaticConstants.USER_ID, userId);

        String apiEndPoint = StaticConstants.ApiEndPoints.READER_DASHBOARD_ENDPOINT;

        HttpUtil.fetchDataFromServer(mActivityContext, apiEndPoint,
                reqParams,
                new HttpUtil.DataListener() {
                    @Override
                    public void requestStart() {
                        mView.showHideLoadingView(true);
                    }

                    @Override
                    public void dataReceived(JSONObject jsonObject) {
                        onSuccess(jsonObject);
                        mView.showHideLoadingView(false);
                    }

                    @Override
                    public void error(JSONObject error) {
                        onFail(error);
                        mView.showHideLoadingView(false);
                    }
                });
    }

    private void onSuccess(JSONObject responseJSON) {
        try {
            Log.d(TAG, "onSuccess: " + responseJSON);
            Gson gson = AppSingeltonData.getInstance().getGsonInstance();
            
            try {
            
            } catch (JsonParseException e) {
                e.printStackTrace();
                Log.e(TAG, "Error Parsing Json: " + e);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void onFail(JSONObject error) {
        try {
            String message = (error == null) ? mActivityContext.getString(R.string.network_error) :
                    (error.getString(mActivityContext.getString(R.string.server_network_error))
                            .equals(mActivityContext.getString(R.string.error_no_internet)) ?
                            mActivityContext.getString(R.string.no_connection) :
                            mActivityContext.getString(R.string.retry_message));

            //mView.showErrorLayout(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Override
    public void sendCleverTapEvent(String eventName, String screenName, @Nullable String location,
                                   @Nullable String type, @Nullable String value) {
        try {
            HashMap<String, Object> properties = new HashMap<>();
            properties.put(CleverTapConstants.SCREEN_NAME, screenName);

            if (location != null)
                properties.put(CleverTapConstants.LOCATION, location);
            if (type != null)
                properties.put(CleverTapConstants.TYPE, type);
            if (value != null)
                properties.put(CleverTapConstants.VALUE, value);

            CleverTapEventUtil.logCleverTapEvent(mActivityContext, eventName, properties);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }	
}