package kr.co.samsungcard.mpocket.view.animationcardview.adapter;

import android.support.v7.widget.RecyclerView;

import java.util.ArrayList;
import java.util.Collections;

import kr.co.samsungcard.mpocket.view.animationcardview.model.AnimationCardModel;

/**
 * Created by Y5001513 on 2016-11-22.
 */
public abstract class AnimationCardViewAdapter extends RecyclerView.Adapter<AnimationCardViewHolder> {
    private ArrayList<? extends AnimationCardModel> mCardList;
    public AnimationCardViewAdapter(ArrayList<AnimationCardModel> list) {
        super();
        mCardList = list;
    }

    public void itemDismiss(int position) {
        getItems().remove(position);
        notifyItemRemoved(position);
    }

    @Override
    public void onBindViewHolder(final AnimationCardViewHolder holder, int position) {
        // Start a drag whenever the handle view it touched
        AnimationCardModel model = getItem(position);
        if(model !=  null) {
            if (model.getImageUrl() != null) {
                //URL로 이미지 불러오기.
            } else {
                holder.cardLayout.setBackgroundResource(model.getDefaultIamgeResource());
            }
        }
    }

    @Override
    public int getItemCount() {
        return mCardList != null ? mCardList.size() : 0;
    }

    public void swapItem(final int fromPosition, final int toPosition) {
        Collections.swap(mCardList, fromPosition, toPosition);
        notifyItemMoved(fromPosition, toPosition);
    }

    public ArrayList<? extends AnimationCardModel> getItems() {
        return mCardList;
    }

    public AnimationCardModel getItem(int position) {
        if(mCardList != null) {
            if(position >= 0 && position < mCardList.size()) {
                return mCardList.get(position);
            }
        }

        return null;
    }
}