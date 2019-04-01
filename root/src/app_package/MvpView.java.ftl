package ${packageName};

import android.os.Bundle;
import com.pratilipi.mobile.android.BaseActivity;

import android.app.Activity;
import android.view.Menu;
import android.view.MenuItem;

import com.pratilipi.mobile.android.StaticConstants;
import com.pratilipi.mobile.android.clevertap.CleverTapConstants;
import com.pratilipi.mobile.android.util.AppUtil;

import butterknife.ButterKnife;

public class ${className}Activity extends BaseActivity implements ${className}Contract.View{

private static final String TAG = ${className}Activity.class.getSimpleName();

private String mSlug, cTParentName, mTitle, mPageUrl;

private ${className}Contract.UserActionListener mActionListener;
private boolean isActive = true;

private Activity mActivityContext = this;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//      setContentView(R.layout.);

        ButterKnife.bind(this);

		mActionListener = new ${className}Presenter(mActivityContext, this);
		
		if (getIntent().getExtras() != null) {
            //Clevertap data..
            cTParentName = getIntent().getStringExtra(StaticConstants.INTENT_EXTRA_PARENT_NAME);

            mSlug = getIntent().getStringExtra(StaticConstants.SLUG);
            mTitle = getIntent().getStringExtra(StaticConstants.INTENT_EXTRA_TITLE);
            mPageUrl = getIntent().getStringExtra(StaticConstants.YOUTUBE_PAGE_URL);

            if (AppUtil.isOnline(mActivityContext)) {
            	//Online
            } else {
                //Offline
            }

        }

        try {
            if (mActionListener != null)
                mActionListener.sendCleverTapEvent(CleverTapConstants.LANDED,
                        null,
                        null,
                        null, null);
        } catch (Exception e) {
            e.printStackTrace();
        }

	}

    @Override
    public void updateUI() {
        try {
            if (isActive) {
            	
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void showHideLoadingView(boolean show) {
        try {
            if (isActive) {
                if (show) {
                	//show loader
                } else {
                	//hide loader
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void showErrorLayout(String message) {
        try {
            if (isActive) {
            	//on error
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


	@Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                onBackPressed();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    public boolean onCreateOptionsMenu(Menu menu) {
        //getMenuInflater().inflate(R.menu.menu_, menu);
        return true;
    }

    @Override
    protected void onStop() {
        super.onStop();
        isActive = false;
    }


}


