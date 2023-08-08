class BaseQuery
  def all
    raise NotImplementedError, 'You should implement this method in a child class.'
  end
end
