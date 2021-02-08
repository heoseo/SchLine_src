package schline;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

@Service
public interface ClassDTOImpl {
	public ArrayList<ClassDTO> listCourse(ClassDTO classdto);
	public ArrayList<VideoDTO> listLecture(VideoDTO videoDTO );


}
