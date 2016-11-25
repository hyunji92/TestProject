package kr.co.samsungcard.mpocket.view.animationcardview;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.LinearLayout;

/**
 * Created by Y5001513 on 2016-11-23.
 */
public class AnimationCardLayout extends LinearLayout{
    public AnimationCardLayout(Context context) {
        this(context, null, -1);
    }

    public AnimationCardLayout(Context context, AttributeSet attrs) {
        this(context, attrs, -1);
    }

    public AnimationCardLayout(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        initialize();
    }

    private void initialize() {
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        if(AnimationCardLayoutManager.getInstance().isCardLayoutScaleLock()) {
            int lockModeHeight = AnimationCardLayoutManager.getInstance().getLockModeCardHeight();

            if(lockModeHeight > 0) {
                int lockModeWidth = (int)((lockModeHeight * AnimationCardLayoutManager.getInstance().getCardWidthRatio()) /  AnimationCardLayoutManager.getInstance().getCardHeightRatio());
                super.onMeasure(MeasureSpec.makeMeasureSpec(lockModeWidth, MeasureSpec.EXACTLY), MeasureSpec.makeMeasureSpec(lockModeHeight, MeasureSpec.EXACTLY));
                return;
            }
        }

        int width = (int)((MeasureSpec.getSize(heightMeasureSpec) * AnimationCardLayoutManager.getInstance().getCardWidthRatio()) /  AnimationCardLayoutManager.getInstance().getCardHeightRatio());
        int makedWidthMeasureSpec = MeasureSpec.makeMeasureSpec(width, MeasureSpec.EXACTLY);
        super.onMeasure(makedWidthMeasureSpec, heightMeasureSpec);

    }
}
