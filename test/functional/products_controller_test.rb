require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = users(:one).id
  end
    
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[title]'
    }
    assert_tag :tag => 'textarea', :attributes => {
      :name => 'product[description]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[image_url]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[price]'
    }
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, :product => {
        :title        => 'awesome product',
        :description  => 'awesome product description',
        :image_url    => 'http://example.com/foo.gif',
        :price        => '100'
      }
    end

    assert_redirected_to product_path(assigns(:product))
  end
  
  test "should not create invalid product" do
    assert_difference('Product.count', 0) do    
      post :create, :product => {
        :title        => '',
        :description  => 'awesome product description',
        :image_url    => 'http://example.com/foo.gif',
        :price        => '100'
      }
    end
    
    assert_not_nil assigns(:product).errors.on :title
  end

  test "should show product" do
    get :show, :id => products(:one).id
    assert_response :success
  end
  
  test "should not show invalid product" do
    get :show, :id => Product.maximum(:id) + 1

    assert_response :redirect
    assert flash[:notice]
  end

  test "should get edit" do
    get :edit, :id => products(:one).id
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[title]'
    }
    assert_tag :tag => 'textarea', :attributes => {
      :name => 'product[description]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[image_url]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[price]'
    }
    assert_response :success
  end
  
  test "should not edit invalid product" do
    get :edit, :id => Product.maximum(:id) + 1

    assert_response :redirect
    assert flash[:notice]
  end

  test "should update product" do
    put :update, :id => products(:one).id, :product => {
      :title => 'mega awesome title'
    }
    assert_redirected_to product_path(assigns(:product))

    assert_equal 'mega awesome title', Product.find(products(:one).id).title
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, :id => products(:one).id
    end

    assert_redirected_to products_path
  end
end
