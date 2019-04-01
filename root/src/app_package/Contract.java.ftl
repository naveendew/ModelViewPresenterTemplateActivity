package ${packageName};

import android.support.annotation.Nullable;


public interface ${className}Contract{
	
	interface View {

        void showHideLoadingView(boolean show);

        void showErrorLayout(String message);

        void updateUI();

	}

	interface UserActionListener {

		void getDatafromServer();

        void sendCleverTapEvent(String eventName, String screenName, @Nullable String location,
                                @Nullable String type, @Nullable String value);


	}
}