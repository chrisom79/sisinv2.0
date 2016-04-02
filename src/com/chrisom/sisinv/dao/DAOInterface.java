package com.chrisom.sisinv.dao;

public interface DAOInterface <T> {
	public String insert(T element);
	public void update(T element) throws Exception;
	public Long countIds(String id);
	public void deleteByField(String field);
}
