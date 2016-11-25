package kr.co.samsungcard.mpocket.view.animationcardview.draggable;

import android.support.v7.widget.RecyclerView;

/**
 * Created by Y5001513 on 2016-11-22.
 */
public interface OnItemTouchHelperListener {
    void onMove(RecyclerView recyclerView, RecyclerView.ViewHolder source, RecyclerView.ViewHolder target);
    void onSelectedChanged(RecyclerView.ViewHolder viewHolder, int actionState);
    void clearView(RecyclerView recyclerView, RecyclerView.ViewHolder viewHolder);
}
