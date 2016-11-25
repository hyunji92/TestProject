package kr.co.samsungcard.mpocket.view.animationcardview;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.sample.horizontalcardview.R;

import java.util.ArrayList;

import kr.co.samsungcard.mpocket.view.animationcardview.adapter.AnimationCardViewAdapter;
import kr.co.samsungcard.mpocket.view.animationcardview.model.AnimationCardModel;
import kr.co.samsungcard.mpocket.view.animationcardview.adapter.AnimationCardViewHolder;

/**
 * Created by Y5001513 on 2016-11-22.
 */
public class SampleAnimationCardViewAdapter extends AnimationCardViewAdapter{
    public SampleAnimationCardViewAdapter(ArrayList<AnimationCardModel> list) {
        super(list);
    }

    @Override
    public AnimationCardViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_card, parent, false);
        AnimationCardViewHolder itemViewHolder = new AnimationCardViewHolder(view);
        return itemViewHolder;

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
}