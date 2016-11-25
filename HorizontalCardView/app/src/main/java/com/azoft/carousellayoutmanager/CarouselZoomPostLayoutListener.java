package com.azoft.carousellayoutmanager;

import android.support.annotation.NonNull;
import android.util.Log;
import android.view.View;

/**
 * Implementation of {@link CarouselLayoutManager.PostLayoutListener} that makes interesting scaling of items. <br />
 * We are trying to make items scaling quicker for closer items for center and slower for when they are far away.<br />
 * Tis implementation uses atan function for this purpose.
 */
public class CarouselZoomPostLayoutListener implements CarouselLayoutManager.PostLayoutListener {
    private float mXAdjusment = 0.6f;
    private float mSizeAdjusment = 1f;
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
            final float translateXGeneral = child.getMeasuredWidth() * (1 - scale) / mXAdjusment;
            translateX = Math.signum(itemPositionToCenterDiff) * translateXGeneral;
            translateY = 0;
        }

        if(scale < mMinimumSize) {
            scale = mMinimumSize;
        }
        return new ItemTransformation(scale * mSizeAdjusment, scale * mSizeAdjusment, translateX, translateY);
    }

    public void setXAdjustment(float adjustment) {
        mXAdjusment = adjustment;
    }

    public void setSizeAdjusment(float adjusment) {
        mSizeAdjusment = adjusment;
    }

    public float getXAdjustment() {
        return mXAdjusment;
    }

    public float getSizeAdjusment() {
        return mSizeAdjusment;
    }

    public float getMinimumSize() {
        return mMinimumSize;
    }

    public void setMinimumSize(float minimumSize) {
        this.mMinimumSize = minimumSize;
    }
}