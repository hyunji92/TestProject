package com.sample.horizontalcardview;

import android.content.Context;
import android.support.v7.widget.LinearLayoutManager;
import android.util.AttributeSet;

/**
 * Created by Y5001513 on 2016-11-21.
 */
public class CustomLayoutManager extends LinearLayoutManager{
    public CustomLayoutManager(Context context) {
        super(context, LinearLayoutManager.HORIZONTAL, false);
    }
}
