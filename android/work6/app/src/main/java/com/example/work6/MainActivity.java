package com.example.work6;

import com.example.work6.AudioItem;
import android.content.ContentUris;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.graphics.Color;
import android.graphics.Paint;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.audiofx.Visualizer;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.provider.MediaStore;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.SeekBar;
import android.widget.TextView;
import android.Manifest;
import android.graphics.Canvas;
import android.graphics.PorterDuff;
import android.net.Uri;
import android.widget.*;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    private MediaPlayer mediaPlayer;
    private Visualizer visualizer;
    private ArrayList<AudioItem> playlist = new ArrayList<>();
    private ArrayAdapter<AudioItem> playlistAdapter;
    private int currentPosition = 0;
    private boolean isPlaying = false;
    private boolean isRepeat = false;
    private Handler progressHandler = new Handler();
    private Paint visualizerPaint = new Paint();
    private SeekBar progressBar;
    private TextView currentTime;
    private TextView totalTime;
    private ImageButton btnRepeat;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_player);

        // 初始化组件
        progressBar = findViewById(R.id.songProgress);
        currentTime = findViewById(R.id.currentTime);
        totalTime = findViewById(R.id.totalTime);
        btnRepeat = findViewById(R.id.btnRepeat);
        SeekBar progressBar = findViewById(R.id.songProgress);
        ListView playlistView = findViewById(R.id.playlist);
        SurfaceView visualizerView = findViewById(R.id.visualizerView);
        ImageButton btnPlay = findViewById(R.id.btnPlay);
        ImageButton btnNext = findViewById(R.id.btnNext);
        ImageButton btnPrev = findViewById(R.id.btnPrev);
        ImageButton btnRepeat = findViewById(R.id.btnRepeat);
        Button btnBrowse = findViewById(R.id.btnBrowse);
        Button btnExit = findViewById(R.id.btnExit);
        TextView currentTime = findViewById(R.id.currentTime);
        TextView totalTime = findViewById(R.id.totalTime);

        // 初始化播放列表适配器
        playlistAdapter = new ArrayAdapter<AudioItem>(
                this,
                android.R.layout.simple_list_item_1,
                playlist
        ) {
            @Override
            public View getView(int position, View convertView, ViewGroup parent) {
                TextView textView = (TextView) super.getView(position, convertView, parent);
                textView.setTextColor(Color.WHITE);
                textView.setText(playlist.get(position).getName());
                return textView;
            }
        };
        playlistView.setAdapter(playlistAdapter);

        // 请求存储权限
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            // Android 13+ 使用 READ_MEDIA_AUDIO
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_MEDIA_AUDIO)
                    != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this,
                        new String[]{Manifest.permission.READ_MEDIA_AUDIO}, 1);
            } else {
                loadAudioFiles(); // 权限已授予，加载音乐
            }
        } else {
            // Android 12 及以下使用 READ_EXTERNAL_STORAGE
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE)
                    != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this,
                        new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, 1);
            } else {
                loadAudioFiles(); // 权限已授予，加载音乐
            }
        }

        // 文件选择监听
        btnBrowse.setOnClickListener(v -> openFilePicker());

        // 退出应用
        btnExit.setOnClickListener(v -> finish());

        // 播放控制
        btnPlay.setOnClickListener(v -> togglePlayback());
        btnNext.setOnClickListener(v -> playNext());
        btnPrev.setOnClickListener(v -> playPrevious());
        btnRepeat.setOnClickListener(v -> toggleRepeatMode());

        // 播放列表点击事件
        playlistView.setOnItemClickListener((parent, view, position, id) -> {
            currentPosition = position;
            AudioItem selectedItem = playlist.get(position); // 这里获取的是AudioItem对象
            playMusic(selectedItem);
        });

        // 进度条控制
        progressBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if (fromUser && mediaPlayer != null) {
                    mediaPlayer.seekTo(progress);
                }
            }

            @Override public void onStartTrackingTouch(SeekBar seekBar) {}
            @Override public void onStopTrackingTouch(SeekBar seekBar) {}
        });

        // 可视化初始化
        visualizerPaint.setColor(Color.argb(200, 76, 175, 80));
        visualizerView.getHolder().addCallback(new SurfaceHolder.Callback() {
            @Override
            public void surfaceCreated(SurfaceHolder holder) {
                setupVisualizer();
            }

            @Override
            public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {}

            @Override
            public void surfaceDestroyed(SurfaceHolder holder) {
                releaseVisualizer();
            }
        });
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (mediaPlayer != null && !isPlaying) {
            releaseVisualizer();
            mediaPlayer.release();
            mediaPlayer = null;
        }
    }

    private void openFilePicker() {
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("audio/*");
        startActivityForResult(intent, 2);
    }

    private void loadAudioFiles() {
        playlist.clear();

        Uri collection = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI;
        String[] projection = {
                MediaStore.Audio.Media._ID,
                MediaStore.Audio.Media.DISPLAY_NAME
        };
        String selection = MediaStore.Audio.Media.IS_MUSIC + " != 0";

        try (Cursor cursor = getContentResolver().query(
                collection,
                projection,
                selection,
                null,
                MediaStore.Audio.Media.DATE_ADDED + " DESC"
        )) {
            if (cursor != null) {
                int idColumn = cursor.getColumnIndexOrThrow(MediaStore.Audio.Media._ID);
                int nameColumn = cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.DISPLAY_NAME);

                while (cursor.moveToNext()) {
                    long id = cursor.getLong(idColumn);
                    String name = cursor.getString(nameColumn);
                    playlist.add(new AudioItem(id, name));
                }
                playlistAdapter.notifyDataSetChanged();
            }
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 2 && resultCode == RESULT_OK && data != null) {
            Uri uri = data.getData();
            try {
                // 直接使用 URI 播放
                playMusicFromUri(uri);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void playMusicFromUri(Uri uri) throws IOException {
        releaseMediaPlayer();
        mediaPlayer = new MediaPlayer();
        mediaPlayer.setDataSource(this, uri); // 使用 URI 设置数据源
        mediaPlayer.prepare();
        mediaPlayer.start();
        isPlaying = true;
        setupProgressUpdater();
        updatePlayButton();
        setupVisualizer();
    }

    private void togglePlayback() {
        if (mediaPlayer == null && !playlist.isEmpty()) {
            playMusic(playlist.get(currentPosition));
        } else if (mediaPlayer != null) {
            if (isPlaying) {
                pauseMusic();
            } else {
                mediaPlayer.start();
                isPlaying = true;
                setupProgressUpdater(); // 恢复进度更新
            }
            updatePlayButton();
        }
    }

    private void playMusic(AudioItem audioItem) {
        try {
            releaseMediaPlayer();
            mediaPlayer = new MediaPlayer();

            // 使用MediaStore ID构建URI
            Uri contentUri = ContentUris.withAppendedId(
                    MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
                    audioItem.getId()
            );

            mediaPlayer.setDataSource(this, contentUri);
            mediaPlayer.setOnPreparedListener(mp -> {
                int duration = mp.getDuration();
                progressBar.setMax(duration);
                totalTime.setText(formatTime(duration));
                mp.start();
                isPlaying = true;
                updatePlayButton();
                setupProgressUpdater();
                new Handler(Looper.getMainLooper()).postDelayed(() -> {
                    setupVisualizer();
                }, 200);
            });
            mediaPlayer.prepareAsync();

        } catch (IOException e) {
            e.printStackTrace();
            Toast.makeText(this, "无法播放文件: " + audioItem.getName(), Toast.LENGTH_SHORT).show();
        }
    }

    private void setupProgressUpdater() {
        progressHandler.removeCallbacksAndMessages(null); // 清除旧任务

        progressHandler.post(new Runnable() {
            @Override
            public void run() {
                if (mediaPlayer != null && mediaPlayer.isPlaying()) {
                    int current = mediaPlayer.getCurrentPosition();
                    int total = mediaPlayer.getDuration();

                    // 更新进度条
                    progressBar.setProgress(current);
                    progressBar.setMax(total);

                    // 更新时间显示
                    currentTime.setText(formatTime(current));
                    totalTime.setText(formatTime(total));

                    // 每500ms更新一次
                    progressHandler.postDelayed(this, 500);
                }
            }
        });
    }

    private String formatTime(int milliseconds) {
        int seconds = (milliseconds / 1000) % 60;
        int minutes = (milliseconds / (1000 * 60)) % 60;
        return String.format("%02d:%02d", minutes, seconds);
    }

    private void pauseMusic() {
        if (mediaPlayer != null && mediaPlayer.isPlaying()) {
            mediaPlayer.pause();
            isPlaying = false;
            updatePlayButton();
        }
    }

    private void playNext() {
        if (!playlist.isEmpty()) {
            currentPosition = (currentPosition + 1) % playlist.size();
            playMusic(playlist.get(currentPosition));
        }
    }

    private void playPrevious() {
        if (!playlist.isEmpty()) {
            currentPosition = (currentPosition - 1 < 0) ? playlist.size() - 1 : currentPosition - 1;
            playMusic(playlist.get(currentPosition));
        }
    }

    private void toggleRepeatMode() {
        isRepeat = !isRepeat;
        btnRepeat.setImageResource(isRepeat ? R.drawable.ic_repeat_on : R.drawable.ic_repeat_off);
    }

    private void updatePlayButton() {
        runOnUiThread(() -> {
            ImageButton btnPlay = findViewById(R.id.btnPlay);
            if (mediaPlayer != null && mediaPlayer.isPlaying()) {
                btnPlay.setImageResource(R.drawable.ic_pause);
                btnPlay.setContentDescription("暂停");
            } else {
                btnPlay.setImageResource(R.drawable.ic_play);
                btnPlay.setContentDescription("播放");
            }
        });
    }

    private void setupVisualizer() {
        if (mediaPlayer == null) return;
        releaseVisualizer();

        int audioSessionId = mediaPlayer.getAudioSessionId();
        if (audioSessionId == AudioManager.ERROR) { // 检查无效会话 ID
            Log.e("Visualizer", "Invalid audio session ID");
            return;
        }

        try {
            visualizer = new Visualizer(audioSessionId);
            visualizer.setCaptureSize(Visualizer.getCaptureSizeRange()[1]);
            visualizer.setDataCaptureListener(new Visualizer.OnDataCaptureListener() {
                @Override
                public void onWaveFormDataCapture(Visualizer visualizer, byte[] waveform, int samplingRate) {
                    drawWaveform(waveform);
                }

                @Override
                public void onFftDataCapture(Visualizer visualizer, byte[] fft, int samplingRate) {}
            }, Visualizer.getMaxCaptureRate(), true, false);
            visualizer.setEnabled(true);
        } catch (RuntimeException e) {
            Log.e("Visualizer", "初始化失败: " + e.getMessage());
            // 处理模拟器兼容性问题
            if (Build.FINGERPRINT.contains("generic")) {
                Toast.makeText(this, "模拟器不支持音频可视化", Toast.LENGTH_SHORT).show();
            }
        }
    }

    private void drawWaveform(byte[] waveform) {
        SurfaceHolder holder = ((SurfaceView) findViewById(R.id.visualizerView)).getHolder();
        Canvas canvas = holder.lockCanvas();
        if (canvas != null) {
            try {
                // 清除画布
                canvas.drawColor(Color.TRANSPARENT, PorterDuff.Mode.CLEAR);

                // 绘制波形
                float width = canvas.getWidth();
                float height = canvas.getHeight();
                float centerY = height / 2;

                for (int i = 0; i < waveform.length; i++) {
                    float x = i * width / waveform.length;
                    float y = (Math.abs(waveform[i]) / 128.0f) * height;
                    canvas.drawLine(x, centerY - y, x, centerY + y, visualizerPaint);
                }
            } finally {
                holder.unlockCanvasAndPost(canvas);
            }
        }
    }

    private void releaseMediaPlayer() {
        if (mediaPlayer != null) {
            try {
                mediaPlayer.reset();  // 重置状态
                mediaPlayer.release(); // 释放资源
            } catch (Exception e) {
                Log.e("MediaPlayer", "释放异常: " + e.getMessage());
            }
            mediaPlayer = null;
            isPlaying = false;
            updatePlayButton();
        }
    }

    private void releaseVisualizer() {
        if (visualizer != null) {
            visualizer.setEnabled(false);
            visualizer.release();
            visualizer = null;
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        releaseMediaPlayer();
        releaseVisualizer();
        progressHandler.removeCallbacksAndMessages(null);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            if (requestCode == 1) {
                loadAudioFiles(); // 权限授予后加载音乐
            }
        } else {
            Toast.makeText(this, "需要权限才能加载音乐", Toast.LENGTH_SHORT).show();
        }
    }
}