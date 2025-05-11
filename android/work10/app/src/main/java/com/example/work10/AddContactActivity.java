package com.example.work10;

import android.content.ContentValues;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

import androidx.appcompat.app.AppCompatActivity;

public class AddContactActivity extends AppCompatActivity {
    private EditText etName, etPhone, etAddress, etWechat, etEmail;
    private DatabaseHelper dbHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_contact);

        dbHelper = new DatabaseHelper(this);
        initializeViews();

        Button btnSave = findViewById(R.id.btnSave);
        btnSave.setOnClickListener(v -> saveContact());
    }

    private void initializeViews() {
        etName = findViewById(R.id.etName);
        etPhone = findViewById(R.id.etPhone);
        etAddress = findViewById(R.id.etAddress);
        etWechat = findViewById(R.id.etWechat);
        etEmail = findViewById(R.id.etEmail);
    }

    private void saveContact() {
        SQLiteDatabase db = dbHelper.getWritableDatabase();
        ContentValues values = new ContentValues();

        values.put("name", etName.getText().toString());
        values.put("phone", etPhone.getText().toString());
        values.put("address", etAddress.getText().toString());
        values.put("wechat", etWechat.getText().toString());
        values.put("email", etEmail.getText().toString());

        db.insert("contacts", null, values);
        finish();
    }
}
