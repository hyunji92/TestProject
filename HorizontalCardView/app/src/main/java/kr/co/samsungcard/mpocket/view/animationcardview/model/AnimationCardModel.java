package kr.co.samsungcard.mpocket.view.animationcardview.model;

import android.os.Parcel;
import android.os.Parcelable;

import org.json.JSONObject;

/**
 * Created by Y5001513 on 2016-11-21.
 */
public class AnimationCardModel implements Parcelable{
    /*
       AnimationCardModel(JSONObject json) 를 사용할시 아래 키값 constant를 수정해서 사용하길..
     */
    public static final String ATTRIBUTE_KEY_CARD_NAME = "cardName";
    public static final String ATTRIBUTE_KEY_CARD_NO = "cardNo";
    public static final String ATTRIBUTE_KEY_IMAGE_URL = "imageUrl";

    private String mCardName;
    private String mCardNo;
    private String mImageUrl;
    private int mDefaultIamgeResource;

    public AnimationCardModel(String cardName, String cardNo, String imageUrl, int defaultImageResource) {
        this.mCardName = cardName;
        this.mCardNo = cardNo;
        this.mImageUrl = imageUrl;
        this.mDefaultIamgeResource = defaultImageResource;
    }

    public AnimationCardModel(String cardName, String cardNo, String imageUrl) {
        this(cardName, cardNo, imageUrl, -1);
    }

    public AnimationCardModel(Parcel in) {
        readFromParcel(in);
    }

    public AnimationCardModel(JSONObject json) {
        if(json == null) {
            return;
        }

        this.mCardName = json.optString(ATTRIBUTE_KEY_CARD_NAME);
        this.mCardNo = json.optString(ATTRIBUTE_KEY_CARD_NO);
        this.mImageUrl = json.optString(ATTRIBUTE_KEY_IMAGE_URL);
        this.mDefaultIamgeResource = -1;
    }

    public String getCardName() {
        return mCardName;
    }

    public void setCardName(String cardName) {
        this.mCardName = cardName;
    }

    public String getCardNo() {
        return mCardNo;
    }

    public void setCardNo(String cardNo) {
        this.mCardNo = cardNo;
    }

    public String getImageUrl() {
        return mImageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.mImageUrl = imageUrl;
    }

    public int getDefaultIamgeResource() {
        return mDefaultIamgeResource;
    }

    public void setDefaultIamgeResource(int defaultIamgeResource) {
        this.mDefaultIamgeResource = defaultIamgeResource;
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel out, int arg1) {
        out.writeString(mCardName);
        out.writeString(mCardNo);
        out.writeString(mImageUrl);
        out.writeInt(mDefaultIamgeResource);
    }

    private void readFromParcel(Parcel in) {
        mCardName = in.readString();
        mCardNo = in.readString();
        mImageUrl = in.readString();
        mDefaultIamgeResource = in.readInt();
    }

    public static final Creator CREATOR = new Creator() {
        @Override
        public AnimationCardModel createFromParcel(Parcel in) {
            return new AnimationCardModel(in);
        }

        @Override
        public AnimationCardModel[] newArray(int size) {
            return new AnimationCardModel[size];
        }
    };
}
