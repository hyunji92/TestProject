package com.sample.horizontalcardview;

import android.animation.Animator;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.animation.ValueAnimator;
import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.Toast;

import com.azoft.carousellayoutmanager.CarouselLayoutManager;
import com.azoft.carousellayoutmanager.CarouselZoomPostLayoutListener;
import com.azoft.carousellayoutmanager.CenterScrollListener;
import com.azoft.carousellayoutmanager.DefaultChildSelectionListener;
import com.sample.horizontalcardview.recycler.RecyclerListAdapter;
import com.sample.horizontalcardview.recycler.helper.ItemTouchHelper;
import com.sample.horizontalcardview.recycler.helper.OnDragAndDropListener;
import com.sample.horizontalcardview.recycler.helper.SimpleItemTouchHelperCallback;

import java.util.ArrayList;
import java.util.Locale;

public class MainActivity extends Activity{

    private ArrayList<CardModel> cardList = new ArrayList<CardModel>();
    private ItemTouchHelper mItemTouchHelper;
    private RecyclerListAdapter mAdapter;
    private RecyclerView recyclerView;
    private int recyclerViewWidth;
    private int recyclerViewHeight;
    private int recyclerViewTop;
    private int deviceHeight;
    private int currentRecyclerViewTop;
    private float currentRecyclerViewSizeAdjustment;
    private float currentRecyclerViewXAdjustment;
    private CarouselLayoutManager mLayoutManager;
    private CarouselZoomPostLayoutListener mPostLayoutListener;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        cardList.add(new CardModel("1번", R.drawable.point_card_border1));
        cardList.add(new CardModel("2번", R.drawable.point_card_border2));
        cardList.add(new CardModel("3번", R.drawable.point_card_border3));
        cardList.add(new CardModel("4번", R.drawable.point_card_border4));
        cardList.add(new CardModel("5번", R.drawable.point_card_border5));
        cardList.add(new CardModel("6번", R.drawable.point_card_border6));


        initRecyclerView();

        ItemTouchHelper.Callback callback = new SimpleItemTouchHelperCallback(mAdapter);
        mItemTouchHelper = new ItemTouchHelper(callback);
        mItemTouchHelper.attachToRecyclerView(recyclerView);


        recyclerView.post(new Runnable() {
            @Override
            public void run() {
                recyclerViewWidth = recyclerView.getWidth();
                recyclerViewHeight = recyclerView.getHeight();
                recyclerViewTop = recyclerView.getTop();

                DisplayMetrics dm = getApplicationContext().getResources().getDisplayMetrics();
                deviceHeight = dm.heightPixels;
                recyclerView.setPivotX(recyclerViewWidth/2);
                recyclerView.setPivotY(recyclerViewHeight/2);
            }
        });
    }

    private void initRecyclerView() {
        recyclerView = (RecyclerView) findViewById(R.id.recycleView);
        mAdapter = new RecyclerListAdapter(this, new OnDragAndDropListener() {
            @Override
            public void onStartDrag(final RecyclerView.ViewHolder viewHolder,View view) {
                mItemTouchHelper.startDrag(viewHolder);
                //mLayoutManager.setMaxVisibleItems(1);
                startAnimationForRecyclerView(true);
//                mPostLayoutListener.setXAdjustment(0.2f);
//                mPostLayoutListener.setSizeAdjusment(2.3f);
//                recyclerView.requestLayout();
            }

            @Override
            public void onEndDrag(RecyclerView.ViewHolder viewHolder) {
                //mLayoutManager.setMaxVisibleItems(0);
                startAnimationForRecyclerView(false);
                mAdapter.notifyDataSetChanged();
//                mPostLayoutListener.setXAdjustment(1.2f);
//                mPostLayoutListener.setSizeAdjusment(2f);
//                recyclerView.requestLayout();
            }

            @Override
            public void onScrollRight(RecyclerView.ViewHolder viewHolder) {
                recyclerView.smoothScrollToPosition(viewHolder.getAdapterPosition() + 1);
            }

            @Override
            public void onScrollLeft(RecyclerView.ViewHolder viewHolder) {
                recyclerView.smoothScrollToPosition(viewHolder.getAdapterPosition() - 1);
            }
        }, cardList);

        mLayoutManager = new CarouselLayoutManager(CarouselLayoutManager.HORIZONTAL, false);
        mPostLayoutListener = new CarouselZoomPostLayoutListener();
        mLayoutManager.setPostLayoutListener(mPostLayoutListener);

        recyclerView.setLayoutManager(mLayoutManager);
        recyclerView.setHasFixedSize(false);
        recyclerView.setAdapter(mAdapter);
        recyclerView.addOnScrollListener(new CenterScrollListener());

        DefaultChildSelectionListener.initCenterItemListener(new DefaultChildSelectionListener.OnCenterItemClickListener() {
            @Override
            public void onCenterItemClicked(@NonNull final RecyclerView recyclerView, @NonNull final CarouselLayoutManager carouselLayoutManager, @NonNull final View v) {
                final int position = recyclerView.getChildLayoutPosition(v);
                final String msg = String.format(Locale.US, "Item %1$d was clicked", position);
                Toast.makeText(MainActivity.this, msg, Toast.LENGTH_SHORT).show();
            }
        }, recyclerView, mLayoutManager);

        mLayoutManager.addOnItemSelectionListener(new CarouselLayoutManager.OnCenterItemSelectionListener() {

            @Override
            public void onCenterItemChanged(final int adapterPosition) {
                if (CarouselLayoutManager.INVALID_POSITION != adapterPosition) {
//                    final int value = adapter.mPosition[adapterPosition];
/*
                    adapter.mPosition[adapterPosition] = (value % 10) + (value / 10 + 1) * 10;
                    adapter.notifyItemChanged(adapterPosition);
*/
                }
            }
        });

        findViewById(R.id.up).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startUpAndScaleDownAnimationForRecyclerView(0.6f,0);
            }
        });

        findViewById(R.id.down).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startDownAndScaleUpAnimationForRecyclerView(0.6f,0);
            }
        });
    }

    public void startUpAndScaleDownAnimationForRecyclerView(float scale, int yPosition) {
        AnimatorSet animatorSet = new AnimatorSet();
        ArrayList<Animator> animatorArray = new ArrayList<Animator>();

        ObjectAnimator animator = ObjectAnimator.ofFloat(recyclerView, "Y", recyclerViewTop, yPosition);
        ValueAnimator animator1 = ValueAnimator.ofFloat(0.7f, 4f);
        animator1.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
            public void onAnimationUpdate(ValueAnimator animation) {
                Float value = (Float) animation.getAnimatedValue();
                mPostLayoutListener.setXAdjustment(value);
            }
        });
        ValueAnimator animator2 = ValueAnimator.ofFloat(1f, scale);
        animator2.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
            public void onAnimationUpdate(ValueAnimator animation) {
                Float value = (Float) animation.getAnimatedValue();
                mPostLayoutListener.setSizeAdjusment(value);
                recyclerView.requestLayout();
            }
        });
        animatorArray.add(animator);
        animatorArray.add(animator1);
        animatorArray.add(animator2);

        Animator[] animators = new Animator[animatorArray.size()];
        animators = animatorArray.toArray(animators);
        animatorSet.playTogether(animators);
        animatorSet.start();

        currentRecyclerViewTop = yPosition;
        currentRecyclerViewSizeAdjustment = scale;
        currentRecyclerViewXAdjustment = 4f;
    }

    public void startDownAndScaleUpAnimationForRecyclerView(float scale, int yPosition) {
        AnimatorSet animatorSet = new AnimatorSet();
        ArrayList<Animator> animatorArray = new ArrayList<Animator>();

        ObjectAnimator animator = ObjectAnimator.ofFloat(recyclerView, "Y", yPosition, recyclerViewTop);
        ValueAnimator animator1 = ValueAnimator.ofFloat(4f, 0.7f);
        animator1.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
            public void onAnimationUpdate(ValueAnimator animation) {
                Float value = (Float) animation.getAnimatedValue();
                mPostLayoutListener.setXAdjustment(value);
            }
        });
        ValueAnimator animator2 = ValueAnimator.ofFloat(scale, 1f);
        animator2.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
            public void onAnimationUpdate(ValueAnimator animation) {
                Float value = (Float) animation.getAnimatedValue();
                mPostLayoutListener.setSizeAdjusment(value);
                recyclerView.requestLayout();
            }
        });
        animatorArray.add(animator);
        animatorArray.add(animator1);
        animatorArray.add(animator2);

        Animator[] animators = new Animator[animatorArray.size()];
        animators = animatorArray.toArray(animators);
        animatorSet.playTogether(animators);
        animatorSet.start();

        currentRecyclerViewTop = recyclerViewTop;
        currentRecyclerViewSizeAdjustment = 1f;
        currentRecyclerViewXAdjustment = 0.7f;
    }

    public void startAnimationForRecyclerView(boolean isStart) {
        if(isStart) {
            AnimatorSet animatorSet = new AnimatorSet();
            ArrayList<Animator> animatorArray = new ArrayList<Animator>();

            ValueAnimator animator1 = ValueAnimator.ofFloat(mPostLayoutListener.getXAdjustment(), 5f);
            animator1.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                public void onAnimationUpdate(ValueAnimator animation) {
                    Float value = (Float) animation.getAnimatedValue();
                    mPostLayoutListener.setXAdjustment(value);
                }
            });
            ValueAnimator animator2 = ValueAnimator.ofFloat(mPostLayoutListener.getSizeAdjusment(), 0.6f);
            animator2.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                public void onAnimationUpdate(ValueAnimator animation) {
                    Float value = (Float) animation.getAnimatedValue();
                    mPostLayoutListener.setSizeAdjusment(value);
                    recyclerView.requestLayout();
                }
            });
            ObjectAnimator animator4 = ObjectAnimator.ofFloat(recyclerView, "Y", currentRecyclerViewTop, 0);
            animatorArray.add(animator1);
            animatorArray.add(animator2);
            animatorArray.add(animator4);

            Animator[] animators = new Animator[animatorArray.size()];
            animators = animatorArray.toArray(animators);
            animatorSet.playTogether(animators);
            animatorSet.addListener(new Animator.AnimatorListener() {
                @Override
                public void onAnimationStart(Animator animator) {
                    recyclerView.getLayoutParams().height = deviceHeight;
                    recyclerView.requestLayout();
                }

                @Override
                public void onAnimationEnd(Animator animator) {

                }

                @Override
                public void onAnimationCancel(Animator animator) {

                }

                @Override
                public void onAnimationRepeat(Animator animator) {

                }
            });
            animatorSet.start();

            currentRecyclerViewSizeAdjustment = 0.6f;
        } else {
            AnimatorSet animatorSet = new AnimatorSet();
            ArrayList<Animator> animatorArray = new ArrayList<Animator>();

            ValueAnimator animator1 = ValueAnimator.ofFloat(mPostLayoutListener.getXAdjustment(), 1f);
            animator1.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                public void onAnimationUpdate(ValueAnimator animation) {
                    Float value = (Float) animation.getAnimatedValue();
                    mPostLayoutListener.setXAdjustment(value);
                }
            });
            ValueAnimator animator2 = ValueAnimator.ofFloat(mPostLayoutListener.getSizeAdjusment(), 1f);
            animator2.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                public void onAnimationUpdate(ValueAnimator animation) {
                    Float value = (Float) animation.getAnimatedValue();
                    mPostLayoutListener.setSizeAdjusment(value);
                    recyclerView.requestLayout();
                }
            });
            ObjectAnimator animator4 = ObjectAnimator.ofFloat(recyclerView, "Y", 0, currentRecyclerViewTop);
            animatorArray.add(animator1);
            animatorArray.add(animator2);
            animatorArray.add(animator4);

            Animator[] animators = new Animator[animatorArray.size()];
            animators = animatorArray.toArray(animators);
            animatorSet.playTogether(animators);
            animatorSet.addListener(new Animator.AnimatorListener() {
                @Override
                public void onAnimationStart(Animator animator) {
                    recyclerView.getLayoutParams().height = recyclerViewHeight;
                    recyclerView.requestLayout();
                }

                @Override
                public void onAnimationEnd(Animator animator) {

                }

                @Override
                public void onAnimationCancel(Animator animator) {

                }

                @Override
                public void onAnimationRepeat(Animator animator) {

                }
            });
            animatorSet.start();

            currentRecyclerViewSizeAdjustment = 1f;
            currentRecyclerViewXAdjustment = 0.7f;
        }
    }
}
