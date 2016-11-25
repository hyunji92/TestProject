/*
 * Copyright (C) 2015 Paul Burke
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.sample.horizontalcardview.recycler;

import android.content.Context;
import android.graphics.Color;
import android.os.Handler;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.sample.horizontalcardview.CardModel;
import com.sample.horizontalcardview.R;
import com.sample.horizontalcardview.recycler.helper.ItemTouchHelperAdapter;
import com.sample.horizontalcardview.recycler.helper.ItemTouchHelperViewHolder;
import com.sample.horizontalcardview.recycler.helper.OnDragAndDropListener;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Simple RecyclerView.Adapter that implements {@link ItemTouchHelperAdapter} to respond to move and
 * dismiss events from a {@link android.support.v7.widget.helper.ItemTouchHelper}.
 *
 * @author Paul Burke (ipaulpro)
 */
public class RecyclerListAdapter extends RecyclerView.Adapter<RecyclerListAdapter.ItemViewHolder>
        implements ItemTouchHelperAdapter {

    private final List<CardModel> mItems = new ArrayList<CardModel>();

    private final OnDragAndDropListener mDragStartListener;

    private ItemViewHolder mSelectedViewHolder;

    public RecyclerListAdapter(Context context, OnDragAndDropListener dragStartListener, ArrayList<CardModel> list) {
        mDragStartListener = dragStartListener;
        mItems.addAll(list);
    }


    @Override
    public ItemViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_card, parent, false);
        ItemViewHolder itemViewHolder = new ItemViewHolder(view);
        itemViewHolder.setIsRecyclable(false);
        return itemViewHolder;

    }

    @Override
    public void onBindViewHolder(final ItemViewHolder holder, int position) {
        // Start a drag whenever the handle view it touched
        holder.convertView.setOnLongClickListener(new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View view) {
                mDragStartListener.onStartDrag(holder, view);
                mSelectedViewHolder = holder;
                return false;
            }
        });
        CardModel mode = mItems.get(position);
        holder.cardView.setImageResource(mode.imageId);
    }

    @Override
    public void onItemDismiss(int position) {
        mItems.remove(position);
        notifyItemRemoved(position);
    }

    @Override
    public boolean onItemMove(final int fromPosition, final int toPosition) {


//        new Handler().postDelayed(new Runnable() {
//            @Override
//            public void run() {
//                Collections.swap(mItems, fromPosition, toPosition);
//            }
//        },500);
        Log.d("test","=========onItemMove=====>>>" + fromPosition + "," + toPosition);
        Collections.swap(mItems, fromPosition, toPosition);
        notifyItemMoved(fromPosition, toPosition);

        return true;
    }

    @Override
    public int getItemCount() {
        return mItems.size();
    }

    public class ItemViewHolder extends RecyclerView.ViewHolder implements
            ItemTouchHelperViewHolder {

        public final ImageView cardView;
        public final View convertView;
        public final View cardLayout;

        public ItemViewHolder(View itemView) {
            super(itemView);
            cardView = (ImageView) itemView.findViewById(R.id.ivCard);
            cardLayout = itemView.findViewById(R.id.cardLayout);
            convertView = itemView;
        }

        @Override
        public void onItemSelected() {
            itemView.setAlpha(0.5f);
        }

        @Override
        public void onItemClear() {
            mDragStartListener.onEndDrag(this);
            itemView.setAlpha(1f);
        }
    }
}
