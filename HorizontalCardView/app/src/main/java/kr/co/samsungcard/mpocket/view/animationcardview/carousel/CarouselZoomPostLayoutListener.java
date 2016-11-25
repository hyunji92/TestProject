package kr.co.samsungcard.mpocket.view.animationcardview.carousel;

import android.support.annotation.NonNull;
import android.view.View;

/**
 * Implementation of {@link CarouselLayoutManager.PostLayoutListener} that makes interesting scaling of items. <br />
 * We are trying to make items scaling quicker for closer items for center and slower for when they are far away.<br />
 * Tis implementation uses atan function for this purpose.
 */
public class CarouselZoomPostLayoutListener implements CarouselLayoutManager.PostLayoutListener {
    private float mScale = 1f;
    private float mMinimumSize = 0.8f;

    @Override
    public ItemTransformation transformChild(@NonNull final View child, final float itemPositionToCenterDiff, final int orientation) {
        float scale = (float) (2 * (2 * -StrictMath.atan(Math.abs(itemPositionToCenterDiff) + 1.0) / Math.PI + 1));
        // because scaling will make view smaller in its center, then we should move this item to the top or bottom to make it visible
        final float translateY;
        final float translateX;

        if (CarouselLayoutManager.VERTICAL == orientation) {
            final float translateYGeneral = child.getMeasuredHeight() * (1 - scale) / 2f;
            translateY = Math.signum(itemPositionToCenterDiff) * translateYGeneral;
            translateX = 0;
        } else {
            final float translateXGeneral = child.getMeasuredWidth() * (1 - scale) / 2;
            translateX = Math.signum(itemPositionToCenterDiff) * translateXGeneral;
            translateY = 0;
        }

        if(scale < mMinimumSize) {
            scale = mMinimumSize;
        }

        return new ItemTransformation(scale * mScale, scale * mScale, 0, 0);
    }

    public void setSizeAdjusment(float adjusment) {
        mScale = adjusment;
    }

    @Override
    public float getScale() {
        return mScale;
    }

    public float getMinimumSize() {
        return mMinimumSize;
    }

    public void setMinimumSize(float minimumSize) {
        this.mMinimumSize = minimumSize;
    }
}