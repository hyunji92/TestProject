package kr.co.samsungcard.mpocket.view.animationcardview.adapter;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;

import com.sample.horizontalcardview.R;

import kr.co.samsungcard.mpocket.view.animationcardview.AnimationCardLayout;

/**
 * Created by Y5001513 on 2016-11-24.
 */
public class AnimationCardViewHolder extends RecyclerView.ViewHolder {

    public final ImageView cardView;
    public final AnimationCardLayout cardLayout;

    public AnimationCardViewHolder(View itemView) {
        super(itemView);
        cardView = (ImageView) itemView.findViewById(R.id.ivCard);
        cardLayout = (AnimationCardLayout) itemView.findViewById(R.id.cardLayout);
        setIsRecyclable(false);
    }
}
