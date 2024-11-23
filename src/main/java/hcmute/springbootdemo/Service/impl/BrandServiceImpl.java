package hcmute.springbootdemo.Service.impl;

import hcmute.springbootdemo.Entity.Brand;
import hcmute.springbootdemo.Repository.BrandRepository;
import hcmute.springbootdemo.Service.IBrandService;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BrandServiceImpl implements IBrandService {
	@Autowired
	BrandRepository brandRepository;

	@Override
	public <S extends Brand> S save(S entity) {
		return brandRepository.save(entity);
	}

	@Override
	public List<Brand> findAll() {
		return brandRepository.findAll();
	}

	@Override
	public Optional<Brand> findById(Integer id) {
		return brandRepository.findById(id);
	}

	@Override
	public long count() {
		return brandRepository.count();
	}

	@Override
	public void deleteById(Integer id) {
		brandRepository.deleteById(id);
	}

	@Override
	public void delete(Brand entity) {
		brandRepository.delete(entity);
	}
	
}
