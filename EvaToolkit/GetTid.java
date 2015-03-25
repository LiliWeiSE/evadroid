package evatoolkit;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.example.weililie.travel.R;

/**
 * Created by weililie on 15/3/24.
 */
public class GetTid extends Activity{
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        final TextView textView = new TextView(this);
        final EditText editText = new EditText(this);
        Button button =  new Button(this);
        LinearLayout layout = new LinearLayout(this);
        textView.setText("感谢使用来自EvaDroid的app！\n请输入您的id, id将关系到积分发放，请确认输入无误");
        button.setText("完成");
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.addView(textView);
        layout.addView(editText);
        layout.addView(button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String[] writeStr = {"<tid>" + editText.getText().toString() + "</tid>"};
                FileUtil.writeLinesToFile(EvaToolkit.getFilePath() + EvaToolkit.getFileName(), writeStr, false);
                finish();
            }
        });
        setContentView(layout);
    }
}
