package kr.co.samsungcard.mpocket.view.animationcardview;

import android.animation.Animator;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.animation.ValueAnimator;
import android.content.Context;
import android.support.annotation.Nullable;
import android.support.v7.widget.RecyclerView;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;
import android.widget.LinearLayout;

import java.util.ArrayList;

import kr.co.samsungcard.mpocket.view.animationcardview.adapter.AnimationCardViewAdapter;
import kr.co.samsungcard.mpocket.view.animationcardview.carousel.CarouselLayoutManager;
import kr.co.samsungcard.mpocket.view.animationcardview.carousel.CarouselZoomPostLayoutListener;
import kr.co.samsungcard.mpocket.view.animationcardview.carousel.CenterScrollListener;
import kr.co.samsungcard.mpocket.view.animationcardview.draggable.CustomItemTouchHelperCallback;
import kr.co.samsungcard.mpocket.view.animationcardview.draggable.ItemTouchHelper;
import kr.co.samsungcard.mpocket.view.animationcardview.draggable.OnItemTouchHelperListener;

/**
 * Created by Y5001513 on 2016-11-22.
 */
public class AnimationCardView extends RecyclerView{

    public static final float EDIT_MODE_VIEW_SCALE = .75f;
    public static final float EDIT_MODE_X_ADJUSTMENT = 2f;

    public static final float NORMAL_MODE_VIEW_SCALE = 1f;

    public static final int INVALID_Y_POSITION = -999999;
    public static final int INVALID_SCALE = -1;

    public enum Mode {
        NORMAL,
        EDIT
    }

    private enum PivotVerticalGravity {
        TOP,
        CENTER_VERTICAL,
        BOTTOM
    }

    private CarouselLayoutManager mLayoutManager;
    private CarouselZoomPostLayoutListener mPostLayoutListener;
    private AnimationCardViewAdapter mAdapter;

    private Mode mCurrentMode = Mode.NORMAL;

    private ItemTouchHelper mItemTouchHelper;

    private int mDeviceHeight;
    private int mDeviceWidth;

    private int mInitializeTop;
    private int mInitializeHeight;
    private float mInitializeScale;

    private int mTopForAnimation;
    private int mHeightForAnimation;
    private float mScaleForAnimation;

    private int mChangedTop;
    private int mChangedHeight;

    private boolean mIsEditable = true;

    private float mWeight = 0;

    private boolean mIsEditAnimating = false;

    private OnAnimationCardViewListener mOnAnimationCardViewListener;

    public interface OnAnimationCardViewListener {
        void onDragStarted(ViewHolder viewHolder);
        void onDragEnded(ViewHolder viewHolder);
        void onCenterItemChanged(int position);
        void onCenterItemClicked(RecyclerView recyclerView, LayoutManager manager, View view);
        void onBackItemClicked(RecyclerView recyclerView, LayoutManager manager, View view);
    }

    private final View.OnClickListener mOnClickListener = new View.OnClickListener() {
        @Override
        public void onClick(final View v) {
            final RecyclerView.ViewHolder holder = getChildViewHolder(v);
            final int position = holder.getAdapterPosition();

            if(mLayoutManager == null) {
                return;
            }

            if (position == mLayoutManager.getCenterItemPosition()) {
                if(mOnAnimationCardViewListener != null) {
                    mOnAnimationCardViewListener.onCenterItemClicked(AnimationCardView.this, mLayoutManager, v);
                }
            } else {
                if(mOnAnimationCardViewListener != null) {
                    mOnAnimationCardViewListener.onBackItemClicked(AnimationCardView.this, mLayoutManager, v);
                }
            }
        }
    };

    private final View.OnLongClickListener mOnLongClickListener = new View.OnLongClickListener() {
        @Override
        public boolean onLongClick(View v) {
            final RecyclerView.ViewHolder holder = getChildViewHolder(v);
            final int position = holder.getAdapterPosition();

            if(mLayoutManager == null) {
                return false;
            }

            if (position == mLayoutManager.getCenterItemPosition()) {
                if(mItemTouchHelper != null) {
                    mItemTouchHelper.startDrag(holder);
                    changeEditMode();
                    if (mOnAnimationCardViewListener != null) {
                        mOnAnimationCardViewListener.onDragStarted(holder);
                    }
                }
            }
            return false;
        }
    };

    private OnItemTouchHelperListener mOnItemTouchHelperListener =  new OnItemTouchHelperListener() {

        @Override
        public void onMove(RecyclerView recyclerView, ViewHolder source, ViewHolder target) {
            if(mAdapter != null) {
                mAdapter.swapItem(source.getAdapterPosition(), target.getAdapterPosition());
            }
        }

        @Override
        public void onSelectedChanged(ViewHolder viewHolder, int actionState) {

        }

        @Override
        public void clearView(RecyclerView recyclerView, ViewHolder viewHolder) {
            changeNormalMode();
            if(mAdapter != null) {
                mAdapter.notifyDataSetChanged();
            }
            if(mOnAnimationCardViewListener != null) {
                mOnAnimationCardViewListener.onDragEnded(viewHolder);
            }
        }
    };

    public AnimationCardView(Context context) {
        this(context, null);
    }

    public AnimationCardView(Context context, @Nullable AttributeSet attrs) {
        this(context, attrs, -1);
    }

    public AnimationCardView(Context context, @Nullable AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        initialize();
    }

    public void setOnAnimationCardViewListener(OnAnimationCardViewListener listener) {
        this.mOnAnimationCardViewListener = listener;
    }

    @Override
    public void setAdapter(Adapter adapter) {
        if(adapter instanceof AnimationCardViewAdapter) {
            mAdapter = (AnimationCardViewAdapter) adapter;
        }
        super.setAdapter(adapter);
    }

    public void setItemPadding(int padding) {
        mLayoutManager.setItemPadding(padding);
    }

    private void initialize() {
        DisplayMetrics dm = getContext().getApplicationContext().getResources().getDisplayMetrics();
        mDeviceHeight = dm.heightPixels - getStatusBarHeight();
        mDeviceWidth = dm.widthPixels;
        setPivotX(0);
        setPivotY(0);

        mLayoutManager = new CarouselLayoutManager(CarouselLayoutManager.HORIZONTAL, false);
        mPostLayoutListener = new CarouselZoomPostLayoutListener();
        mLayoutManager.setPostLayoutListener(mPostLayoutListener);

        ItemTouchHelper.Callback callback = new CustomItemTouchHelperCallback(mOnItemTouchHelperListener);
        mItemTouchHelper = new ItemTouchHelper(callback);
        mItemTouchHelper.attachToRecyclerView(this);

        setLayoutManager(mLayoutManager);
        setHasFixedSize(false);
        addOnScrollListener(new CenterScrollListener());

        addOnChildAttachStateChangeListener(new RecyclerView.OnChildAttachStateChangeListener() {
            @Override
            public void onChildViewAttachedToWindow(final View view) {
                view.setOnClickListener(mOnClickListener);
                view.setOnLongClickListener(mOnLongClickListener);
            }

            @Override
            public void onChildViewDetachedFromWindow(final View view) {
                view.setOnClickListener(null);
                view.setOnLongClickListener(null);
            }
        });

        mLayoutManager.addOnItemSelectionListener(new CarouselLayoutManager.OnCenterItemSelectionListener() {

            @Override
            public void onCenterItemChanged(final int adapterPosition) {
                if (CarouselLayoutManager.INVALID_POSITION != adapterPosition) {
                    if(mOnAnimationCardViewListener != null) {
                        mOnAnimationCardViewListener.onCenterItemChanged(adapterPosition);
                    }
                }
            }
        });

        initializeVariables();
    }

    private void changePivotY(final PivotVerticalGravity pivotGravity) {
        post(new Runnable() {
            @Override
            public void run() {
                int pivotPoint = 0;
                switch (pivotGravity) {
                    case TOP:
                        pivotPoint = 0;
                        break;
                    case CENTER_VERTICAL:
                        pivotPoint = getMeasuredHeight() / 2;
                        break;
                    case BOTTOM:
                        pivotPoint = getMeasuredHeight();
                        break;
                }
                setPivotY(pivotPoint);
            }
        });
    }

    private void initializeVariables() {
        post(new Runnable() {
            @Override
            public void run() {
                mInitializeTop = getTop();
                mInitializeHeight = getMeasuredHeight();
                mInitializeScale = mPostLayoutListener.getScale();

                mTopForAnimation = mInitializeTop;
                mHeightForAnimation = mInitializeHeight;
                mScaleForAnimation = mInitializeScale;

                mChangedTop = mInitializeTop;
                mChangedHeight = mInitializeHeight;

                if(getLayoutParams() instanceof  LinearLayout.LayoutParams) {
                    LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) getLayoutParams();
                    if (params != null) {
                        mWeight = params.weight;
                    }
                }

                AnimationCardLayoutManager.getInstance().setLockModeCardHeight(mInitializeHeight - getPaddingBottom() - getPaddingTop());
            }
        });
    }

    @Override
    protected void onMeasure(int widthSpec, int heightSpec) {
        if(mIsEditAnimating == false) {
            mChangedHeight = MeasureSpec.getSize(heightSpec);
            AnimationCardLayoutManager.getInstance().setLockModeCardHeight(mChangedHeight - getPaddingBottom() - getPaddingTop());
            mChangedTop = getTop();
        }

        super.onMeasure(widthSpec, heightSpec);
    }

    public void setEditable(boolean editable) {
        mIsEditable = editable;
    }

    public boolean isEditable() {
        return mIsEditable;
    }

    public boolean isEditMode() {
        return mCurrentMode == Mode.EDIT;
    }

    private void changeMode(Mode mode) {
        if(mIsEditable == false) {
            return;
        }

        switch (mode) {
            case NORMAL: {

                changePivotY(PivotVerticalGravity.TOP);
                ArrayList<Animator> aniamtors = new ArrayList<Animator>();
                ValueAnimator animatorHeight = ValueAnimator.ofFloat(mHeightForAnimation, mChangedHeight);
                animatorHeight.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                    public void onAnimationUpdate(ValueAnimator animation) {
                        Float value = (Float) animation.getAnimatedValue();
                        getLayoutParams().height = value.intValue();
                        requestLayout();
                    }
                });
                Animator animatorTop = getYPositionAnimator(mTopForAnimation, mChangedTop);
                aniamtors.add(animatorHeight);
                aniamtors.add(animatorTop);
                startAnimation(aniamtors, new Animator.AnimatorListener() {
                    @Override
                    public void onAnimationStart(Animator animator) {
                        ArrayList<Animator> aniamtors = new ArrayList<Animator>();
                        aniamtors.add(getScaleAnimator(mScaleForAnimation, NORMAL_MODE_VIEW_SCALE));
                        startAnimation(aniamtors, new Animator.AnimatorListener() {
                            @Override
                            public void onAnimationStart(Animator animator) {

                            }

                            @Override
                            public void onAnimationEnd(Animator animator) {
                                restoreLayoutWeightIfNeeded();
                                mIsEditAnimating = false;
                            }

                            @Override
                            public void onAnimationCancel(Animator animator) {

                            }

                            @Override
                            public void onAnimationRepeat(Animator animator) {

                            }
                        });

                        mScaleForAnimation = 1f;
                        mTopForAnimation = mChangedTop;
                        mHeightForAnimation = mChangedHeight;
                    }

                    @Override
                    public void onAnimationEnd(Animator animator) {
                        AnimationCardLayoutManager.getInstance().setCardLayoutScaleLock(false);
                    }

                    @Override
                    public void onAnimationCancel(Animator animator) {

                    }

                    @Override
                    public void onAnimationRepeat(Animator animator) {

                    }
                });
            }
                break;
            case EDIT: {
                mIsEditAnimating = true;
                removeLayoutWeighifNeeded();
                AnimationCardLayoutManager.getInstance().setCardLayoutScaleLock(true);
                changePivotY(PivotVerticalGravity.TOP);
                ArrayList<Animator> aniamtors = new ArrayList<Animator>();
                ValueAnimator animatorHeight = ValueAnimator.ofFloat(mChangedHeight, mDeviceHeight);
                animatorHeight.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                    public void onAnimationUpdate(ValueAnimator animation) {
                        Float value = (Float) animation.getAnimatedValue();
                        getLayoutParams().height = value.intValue();
                        requestLayout();
                    }
                });
                Animator animatorTop = getYPositionAnimator(mChangedTop, 0);
                aniamtors.add(animatorHeight);
                aniamtors.add(animatorTop);
                startAnimation(aniamtors, new Animator.AnimatorListener() {
                    @Override
                    public void onAnimationStart(Animator animator) {
                        ArrayList<Animator> aniamtors = new ArrayList<Animator>();
                        aniamtors.add(getScaleAnimator(1f, EDIT_MODE_VIEW_SCALE));
                        startAnimation(aniamtors, new Animator.AnimatorListener() {
                            @Override
                            public void onAnimationStart(Animator animator) {

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

                        mScaleForAnimation = EDIT_MODE_VIEW_SCALE;
                        mHeightForAnimation = mDeviceHeight;
                        mTopForAnimation = 0;
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
            }
                break;
        }
        mCurrentMode = mode;
    }

    public void changeNormalMode() {
        if(isEditable() && isEditMode()) {
            changeMode(Mode.NORMAL);
        }
    }

    public void changeEditMode() {
        if(isEditable() && isEditMode() == false) {
            changeMode(Mode.EDIT);
        }
    }

    public void removeLayoutWeighifNeeded() {
        if(mWeight > 0) {
            LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) getLayoutParams();
            params.height = mChangedHeight;
            params.weight = 0;
            requestLayout();
        }
    }

    public void restoreLayoutWeightIfNeeded() {
        if(mWeight > 0) {
            LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) getLayoutParams();
            params.height = 0;
            params.weight = mWeight;
            requestLayout();
        }
    }

    public void changeHeight(final int height, Animator... animators) {
        changeHeightAndYPosition(height, INVALID_Y_POSITION, animators);
    }

    public void changeHeightAndYPosition(final int height, int yPosition, Animator... animators) {
        final boolean scaleChangeNeeded = height > 0;
        final boolean yPositionChangeNeeded = yPosition != INVALID_Y_POSITION;

        final ArrayList<Animator> animatorList = new ArrayList<Animator>();
        if(scaleChangeNeeded) {
            ValueAnimator animatorSize = ValueAnimator.ofFloat(mChangedHeight, height);
            animatorSize.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                public void onAnimationUpdate(ValueAnimator animation) {
                    Float value = (Float) animation.getAnimatedValue();
                    getLayoutParams().height = value.intValue();
                    requestLayout();
                }
            });
            animatorList.add(animatorSize);
        }

        if(animators != null) {
            for(int i=0 ; i<animators.length ; i++) {
                if(animators[i] != null) {
                    animatorList.add(animators[i]);
                }
            }
        }

        if(yPositionChangeNeeded) {
            Animator animatorTop = getYPositionAnimator(mChangedTop, yPosition);
            animatorTop.addListener(new Animator.AnimatorListener() {
                @Override
                public void onAnimationStart(Animator animator) {
                    startAnimation(animatorList, null);
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
            animatorTop.start();
        } else {
            startAnimation(animatorList, null);
        }

        if(scaleChangeNeeded) {
            mChangedHeight = height;
            AnimationCardLayoutManager.getInstance().setLockModeCardHeight(mChangedHeight - getPaddingBottom() - getPaddingTop());
        }

        if(yPositionChangeNeeded) {
            mChangedTop = yPosition;
        }
    }

    public int getCurrentTop() {
        return mChangedTop;
    }

    public int getInitializeTop() {
        return mInitializeTop;
    }

    public int getCurrentHeight() {
        return mChangedHeight;
    }

    public int getInitializeHeight() {
        return mInitializeHeight;
    }

    public void changeYPosition(int yPosition, Animator... animators) {
        changeHeightAndYPosition(INVALID_SCALE, yPosition, animators);
    }

    public Animator getYPositionAnimator(float fromYPosition, float toYPosition) {
        return ObjectAnimator.ofFloat(this, "Y", fromYPosition, toYPosition);
    }

    public Animator getScaleAnimator(float fromScale, float toScale) {
        ValueAnimator animator = ValueAnimator.ofFloat(fromScale, toScale);
        animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
            public void onAnimationUpdate(ValueAnimator animation) {
                Float value = (Float) animation.getAnimatedValue();
                mPostLayoutListener.setSizeAdjusment(value);
                requestLayout();
            }
        });
        return animator;
    }

    public void startAnimation(Animator[] animators, Animator.AnimatorListener listener) {
        if(animators != null) {
            AnimatorSet animatorSet = new AnimatorSet();
            animatorSet.playTogether(animators);
            if(listener != null) {
                animatorSet.addListener(listener);
            }
            animatorSet.start();
        }
    }

    public void startAnimation(ArrayList<Animator> animatorList, Animator.AnimatorListener listener) {
        if(animatorList != null && animatorList.size() > 0) {
            Animator[] animators = new Animator[animatorList.size()];
            animators = animatorList.toArray(animators);
            startAnimation(animators, listener);
        }
    }

    public int getStatusBarHeight() {
        int result = 0;
        int resourceId = getResources().getIdentifier("status_bar_height", "dimen", "android");
        if(resourceId > 0) {
            result = getResources().getDimensionPixelSize(resourceId);
        }
        return result;
    }
}
