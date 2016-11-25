package kr.co.samsungcard.mpocket.view.animationcardview;

/**
 * Created by Y5001513 on 2016-11-23.
 */
public class AnimationCardLayoutManager {
    public static final float DEFAULT_CARD_WIDTH_RATIO = 1.5f;
    public static final float DEFAULT_CARD_HEIGHT_RATIO = 1f;

    private boolean mCardLayoutScaleLock = false;

    private float mCurrentWidthRatio = DEFAULT_CARD_WIDTH_RATIO;
    private float mCurrentHeightRatio = DEFAULT_CARD_HEIGHT_RATIO;

    private int mLockModeCardHeight;

    private static class SingletonHolder {
        static final AnimationCardLayoutManager INSTANCE = new AnimationCardLayoutManager();
    }

    public static AnimationCardLayoutManager getInstance() {
        return SingletonHolder.INSTANCE;
    }

    private AnimationCardLayoutManager() {
        initialize();
    }

    private void initialize() {

    }

    public void setCardLayoutScaleLock(boolean scaleLock) {
        mCardLayoutScaleLock = scaleLock;
    }

    public boolean isCardLayoutScaleLock() {
        return mCardLayoutScaleLock;
    }

    public int getLockModeCardHeight() {
        return mLockModeCardHeight;
    }

    public float getCardWidthRatio() {
        return mCurrentWidthRatio;
    }

    public  float getCardHeightRatio() {
        return mCurrentHeightRatio;
    }

    public void setLockModeCardHeight(int height) {
        mLockModeCardHeight = height;
    }

    public void setCardWidthRatio(float ratio) {
        mCurrentWidthRatio = ratio;
    }

    public void setCardHeightRatio(float ratio) {
        mCurrentHeightRatio = ratio;
    }
}
