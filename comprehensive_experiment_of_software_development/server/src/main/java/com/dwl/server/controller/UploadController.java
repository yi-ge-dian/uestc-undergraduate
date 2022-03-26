package com.dwl.server.controller;

import org.springframework.core.io.FileSystemResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.*;

import io.micrometer.core.instrument.util.IOUtils;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

@RestController
public class UploadController {
    @GetMapping("/filelist")
    Serializable filelist() throws FileNotFoundException {
        StringBuffer str = new StringBuffer("");
        str.append("[");
        File f = new File("./");
        if (!f.exists()) {
            return "error";
        }
        File fa[] = f.listFiles();
        for (int i = 0; i < fa.length; i++) {
            File fs = fa[i];
            if (fs.isFile()) {
                if (fs.getName().equals("backup.jar")){
                    continue;
                }
                if (i==fa.length-1){
                    str.append("\""+fs.getName()+"\"");
                }else{
                    str.append("\""+fs.getName()+"\""+",");
                }
            }
        }
        str.append("]");
        return str;
    }

    @PutMapping("/file/{filename}")
    public String add(HttpServletRequest request, @PathVariable String filename){
        try {

            BufferedWriter out = new BufferedWriter(new FileWriter("./"+filename));
            out.write(StreamUtils.copyToString(request.getInputStream(), Charset.forName(StandardCharsets.UTF_8.name())));
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
            return "error";
        }
        return "success";
    };

    @DeleteMapping("/file/{filename}")
    public String delete(@PathVariable String filename) throws IOException {
        File file=new File("./"+filename);
        if (file.exists()) {
            boolean a=file.delete();
            file=null;
            if(a)
                return "success";
            else
                return "error";
        } else {
            return "error";
        }
    }

    @GetMapping("/file/{filename}")
    public String get(@PathVariable String filename) throws IOException {
        String filePath="./"+filename;
        Resource resource = new FileSystemResourceLoader().getResource(filePath);
        if(resource.exists()) {
            InputStream inputStream = resource.getInputStream();
            String content = IOUtils.toString(inputStream, StandardCharsets.UTF_8);
            return content;
        }else
            return "error";
    }

}
