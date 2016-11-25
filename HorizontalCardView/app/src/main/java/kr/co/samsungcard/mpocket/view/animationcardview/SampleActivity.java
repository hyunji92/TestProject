package kr.co.samsungcard.mpocket.view.animationcardview;

import android.animation.Animator;
import android.animation.ValueAnimator;
import android.app.Activity;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;

import com.sample.horizontalcardview.R;

import java.util.ArrayList;

import kr.co.samsungcard.mpocket.view.animationcardview.model.AnimationCardModel;

/**
 * Created by Y5001513 on 2016-11-22.
 */
public class SampleActivity extends Activity{
    private final String TAG = SampleActivity.class.getName();
    private ArrayList<AnimationCardModel> mCardList = new ArrayList<AnimationCardModel>();
    private AnimationCardView mAnimationCardView;
    private SampleAnimationCardViewAdapter mAdapter;

    private int mCenterPosition;

    private AnimationCardView.OnAnimationCardViewListener mAnimationCardViewLisntener = new AnimationCardView.OnAnimationCardViewListener() {
        @Override
        public void onDragStarted(RecyclerView.ViewHolder viewHolder) {
            Log.d(TAG, "onDragStarted position : " + viewHolder.getAdapterPosition());
        }

        @Override
        public void onDragEnded(RecyclerView.ViewHolder viewHolder) {
            Log.d(TAG, "onDragEnded position : " + viewHolder.getAdapterPosition());
        }

        @Override
        public void onCenterItemChanged(int position) {
            Log.d(TAG, "onCenterItemChanged position : " + position);
            mCenterPosition = position;
        }

        @Override
        public void onCenterItemClicked(RecyclerView recyclerView, RecyclerView.LayoutManager manager, View view) {
            Log.d(TAG, "onCenterItemClicked position : " + manager.getPosition(view));
        }

        @Override
        public void onBackItemClicked(RecyclerView recyclerView, RecyclerView.LayoutManager manager, View view) {
            Log.d(TAG, "onBackItemClicked position : " + manager.getPosition(view));
            recyclerView.smoothScrollToPosition(manager.getPosition(view));
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sample);
        initData();
        initViews();
    }

    private void initData() {
        mCardList.add(new AnimationCardModel("1번", "1", null, R.drawable.point_card_border1));
        mCardList.add(new AnimationCardModel("2번", "2", null, R.drawable.point_card_border2));
        mCardList.add(new AnimationCardModel("3번", "3", null, R.drawable.point_card_border3));
        mCardList.add(new AnimationCardModel("4번", "4", null, R.drawable.point_card_border4));
        mCardList.add(new AnimationCardModel("5번", "5", null, R.drawable.point_card_border5));
        mCardList.add(new AnimationCardModel("6번", "6", null, R.drawable.point_card_border6));
    }

    private void initAnimationCardView() {
        mAnimationCardView = (AnimationCardView) findViewById(R.id.animationCardView);

        mAdapter = new SampleAnimationCardViewAdapter(mCardList);
        mAnimationCardView.setOnAnimationCardViewListener(mAnimationCardViewLisntener);
        mAnimationCardView.setAdapter(mAdapter);

        DisplayMetrics dm = getApplicationContext().getResources().getDisplayMetrics();
        mAnimationCardView.setItemPadding((int)dm.density * 10);
    }

    private void initViews() {
        initAnimationCardView();

        findViewById(R.id.topHeightUp).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.d(TAG, "onClick up:" + mAnimationCardView.getCurrentTop() + "," + mAnimationCardView.getCurrentHeight());
                DisplayMetrics dm = getApplicationContext().getResources().getDisplayMetrics();
                ValueAnimator animator = ValueAnimator.ofFloat(dm.density * 60 , dm.density * 100);
                animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                    @Override
                    public void onAnimationUpdate(ValueAnimator valueAnimator) {
                        Float value = (Float) valueAnimator.getAnimatedValue();
                        findViewById(R.id.topLayout).getLayoutParams().height = value.intValue();
                        findViewById(R.id.topLayout).requestLayout();
                        mAnimationCardView.requestLayout();
                    }
                });
                animator.start();
            }
        });

        findViewById(R.id.topHeightDown).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.d(TAG, "onClick up:" + mAnimationCardView.getCurrentTop() + "," + mAnimationCardView.getCurrentHeight());
                DisplayMetrics dm = getApplicationContext().getResources().getDisplayMetrics();
                ValueAnimator animator = ValueAnimator.ofFloat(dm.density * 100 , dm.density * 60);
                animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                    @Override
                    public void onAnimationUpdate(ValueAnimator valueAnimator) {
                        Float value = (Float) valueAnimator.getAnimatedValue();
                        findViewById(R.id.topLayout).getLayoutParams().height = value.intValue();
                        findViewById(R.id.topLayout).requestLayout();
                        mAnimationCardView.requestLayout();
                    }
                });
                animator.start();
            }
        });

        findViewById(R.id.bottomHeightUp).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.d(TAG, "onClick up:" + mAnimationCardView.getCurrentTop() + "," + mAnimationCardView.getCurrentHeight());
                DisplayMetrics dm = getApplicationContext().getResources().getDisplayMetrics();
                ValueAnimator animator = ValueAnimator.ofFloat(dm.density * 60 , dm.density * 100);
                animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                    @Override
                    public void onAnimationUpdate(ValueAnimator valueAnimator) {
                        Float value = (Float) valueAnimator.getAnimatedValue();
                        findViewById(R.id.bottomLayout).getLayoutParams().height = value.intValue();
                        findViewById(R.id.bottomLayout).requestLayout();
                        mAnimationCardView.requestLayout();
                    }
                });
                animator.start();
            }
        });

        findViewById(R.id.bottomHeightDown).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.d(TAG, "onClick up:" + mAnimationCardView.getCurrentTop() + "," + mAnimationCardView.getCurrentHeight());
                DisplayMetrics dm = getApplicationContext().getResources().getDisplayMetrics();
                ValueAnimator animator = ValueAnimator.ofFloat(dm.density * 100 , dm.density * 60);
                animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                    @Override
                    public void onAnimationUpdate(ValueAnimator valueAnimator) {
                        Float value = (Float) valueAnimator.getAnimatedValue();
                        findViewById(R.id.bottomLayout).getLayoutParams().height = value.intValue();
                        findViewById(R.id.bottomLayout).requestLayout();
                        mAnimationCardView.requestLayout();
                    }
                });
                animator.start();
            }
        });

        findViewById(R.id.weight0).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mAnimationCardView.removeLayoutWeighifNeeded();
            }
        });

        findViewById(R.id.weight1).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mAnimationCardView.restoreLayoutWeightIfNeeded();
            }
        });

        findViewById(R.id.up).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.d(TAG, "onClick up:" + mAnimationCardView.getCurrentTop() + "," + mAnimationCardView.getCurrentHeight());
                DisplayMetrics dm = getApplicationContext().getResources().getDisplayMetrics();
                mAnimationCardView.changeHeight(mAnimationCardView.getCurrentHeight() + (int)(dm.density * 10), null);
            }
        });

        findViewById(R.id.down).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.d(TAG, "onClick down:" + mAnimationCardView.getCurrentTop() + "," + mAnimationCardView.getCurrentHeight());
                DisplayMetrics dm = getApplicationContext().getResources().getDisplayMetrics();
                mAnimationCardView.changeHeight(mAnimationCardView.getCurrentHeight() - (int)(dm.density * 10), null);
            }
        });

        findViewById(R.id.reset).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.d(TAG, "onClick current:" + mAnimationCardView.getCurrentTop() + "," + mAnimationCardView.getCurrentHeight());
                mAnimationCardView.changeHeightAndYPosition(mAnimationCardView.getInitializeHeight(), mAnimationCardView.getInitializeTop(), null);
            }
        });

        findViewById(R.id.insert).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.d(TAG, "onClick insert:" + mAnimationCardView.getCurrentTop() + "," + mAnimationCardView.getCurrentHeight());
                mCardList.add(mCenterPosition, new AnimationCardModel("추가", "1", null, R.drawable.point_card_border6));
                mAdapter.notifyItemInserted(mCenterPosition);
            }
        });
        findViewById(R.id.delete).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.d(TAG, "onClick delete:" + mAnimationCardView.getCurrentTop() + "," + mAnimationCardView.getCurrentHeight());
                mCardList.remove(mCenterPosition);
                mAdapter.notifyItemRemoved(mCenterPosition);
            }
        });
    }
}
