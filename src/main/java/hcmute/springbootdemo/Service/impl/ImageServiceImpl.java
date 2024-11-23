package hcmute.springbootdemo.Service.impl;

import hcmute.springbootdemo.Entity.Image;
import hcmute.springbootdemo.Repository.ImageRepository;
import hcmute.springbootdemo.Service.IImageService;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;
@Service
public class ImageServiceImpl implements IImageService {

    @Autowired
    ImageRepository imageRepository;

	@Override
	public <S extends Image> S save(S entity) {
		return imageRepository.save(entity);
	}

	@Override
	public List<Image> findAll() {
		return imageRepository.findAll();
	}

	@Override
	public Optional<Image> findById(Integer id) {
		return imageRepository.findById(id);
	}

	@Override
	public boolean existsById(Integer id) {
		return imageRepository.existsById(id);
	}

	@Override
	public <S extends Image> boolean exists(Example<S> example) {
		return imageRepository.exists(example);
	}

	@Override
	public long count() {
		return imageRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		imageRepository.deleteById(id);
	}

	@Override
	public void delete(Image entity) {
		imageRepository.delete(entity);
	}

	@Override
	public List<Image> findImagesByProductId(int productId) {
		return imageRepository.findByProductId(productId);
	}
    
}
