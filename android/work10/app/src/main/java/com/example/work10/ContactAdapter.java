package com.example.work10;

import android.database.Cursor;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

public class ContactAdapter extends RecyclerView.Adapter<ContactAdapter.ViewHolder> {
    private Cursor cursor;

    public ContactAdapter(Cursor cursor) {
        this.cursor = cursor;
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {
        TextView tvName, tvPhone, tvAddress, tvWechat, tvEmail;

        public ViewHolder(View itemView) {
            super(itemView);
            tvName = itemView.findViewById(R.id.tvName);
            tvPhone = itemView.findViewById(R.id.tvPhone);
            tvAddress = itemView.findViewById(R.id.tvAddress);
            tvWechat = itemView.findViewById(R.id.tvWechat);
            tvEmail = itemView.findViewById(R.id.tvEmail);
        }
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_contact, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        if (!cursor.moveToPosition(position)) return;

        holder.tvName.setText(cursor.getString(cursor.getColumnIndex("name")));
        holder.tvPhone.setText(cursor.getString(cursor.getColumnIndex("phone")));
        holder.tvAddress.setText(cursor.getString(cursor.getColumnIndex("address")));
        holder.tvWechat.setText(cursor.getString(cursor.getColumnIndex("wechat")));
        holder.tvEmail.setText(cursor.getString(cursor.getColumnIndex("email")));
    }

    @Override
    public int getItemCount() {
        return cursor.getCount();
    }
}
