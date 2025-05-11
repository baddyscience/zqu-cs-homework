package com.example.work8;

import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;

import org.json.JSONException;
import org.json.JSONObject;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class MainActivity extends AppCompatActivity {
    private EditText etUsername, etPassword;
    private Button btnSubmit;
    private LinearLayout layoutSuccess, layoutFail;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etUsername = findViewById(R.id.etUsername);
        etPassword = findViewById(R.id.etPassword);
        btnSubmit = findViewById(R.id.btnSubmit);
        layoutSuccess = findViewById(R.id.layoutSuccess);
        layoutFail = findViewById(R.id.layoutFail);

        btnSubmit.setOnClickListener(v -> new LoginTask().execute());
    }

    private class LoginTask extends AsyncTask<Void, Void, String> {
        @Override
        protected String doInBackground(Void... voids) {
            try (Socket socket = new Socket("10.0.2.2", 8080)) { // Android模拟器本机地址
                // 发送凭证
                OutputStream os = socket.getOutputStream();
                PrintWriter pw = new PrintWriter(os);
                pw.println(etUsername.getText() + ":" + etPassword.getText());
                pw.flush();

                // 获取响应
                InputStream is = socket.getInputStream();
                BufferedReader br = new BufferedReader(new InputStreamReader(is));
                return br.readLine();
            } catch (Exception e) {
                return "ERROR: " + e.getMessage(); // 携带错误信息
            }
        }

        @Override
        protected void onPostExecute(String result) {
            runOnUiThread(() -> {
                if(result.equals("SUCCESS")) {
                    layoutSuccess.setVisibility(View.VISIBLE);
                    layoutFail.setVisibility(View.GONE);
                } else if(result.equals("FAIL")) {
                    layoutSuccess.setVisibility(View.GONE);
                    layoutFail.setVisibility(View.VISIBLE);
                } else {
                    // 显示网络错误
                    Toast.makeText(MainActivity.this,
                            "服务器连接失败: "+result,
                            Toast.LENGTH_LONG).show();
                }
            });
        }
    }
}
