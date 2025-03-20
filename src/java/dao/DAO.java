package dao;

import context.DBContext;
import entity.Account;
import entity.Category;
import entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Close resources to avoid memory leaks
    private void closeConnection() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get all products
    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM product";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return list;
    }

    // Get top 3 products
    public List<Product> getTop3() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT TOP 3 * FROM product";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return list;
    }

    // Get next 3 products starting from the given amount
    public List<Product> getNext3Product(int amount) {
        List<Product> list = new ArrayList<>();
        String query = """
                       SELECT *
                         FROM product
                        ORDER BY id
                       OFFSET ? ROWS
                        FETCH NEXT 3 ROWS ONLY""";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setInt(1, amount);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return list;
    }

    // Get products by category ID
    public List<Product> getProductByCID(String cid) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM product WHERE cateID = ?";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setString(1, cid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return list;
    }

    // Get products by seller ID
    public List<Product> getProductBySellID(int id) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM product WHERE sell_ID = ?";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return list;
    }

    // Search products by name
    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM product WHERE [name] LIKE ?";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return list;
    }

    // Get product by ID
    public Product getProductByID(String id) {
        String query = "SELECT * FROM product WHERE id = ?";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return null;
    }

    // Get all categories
    public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String query = "SELECT * FROM Category";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return list;
    }

    // Get last inserted product
    public Product getLast() {
        String query = "SELECT TOP 1 * FROM product ORDER BY id DESC";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return null;
    }

    // Login method
    public Account login(String user, String pass) {
        String query = "SELECT * FROM account WHERE [user] = ? AND pass = ?";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return null;
    }

    // Check if account exists
    public Account checkAccountExist(String user) {
        String query = "SELECT * FROM account WHERE [user] = ?";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
        return null;
    }

    // Register new account
    public void singup(String user, String pass) {
        String query = "INSERT INTO account VALUES(?,?,0,0)";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
    }

    // Delete product by ID
    public void deleteProduct(String pid) {
        String query = "DELETE FROM product WHERE id = ?";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setString(1, pid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
    }

    // Insert new product
    public void insertProduct(String name, String image, String price, String title, String description, String category, int sid) {
        String query = """
                       INSERT INTO [dbo].[product] ([name], [image], [price], [title], [description], [cateID], [sell_ID])
                       VALUES(?,?,?,?,?,?,?)""";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setString(3, price);
            ps.setString(4, title);
            ps.setString(5, description);
            ps.setString(6, category);
            ps.setInt(7, sid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
    }

    // Edit existing product
    public void editProduct(String name, String image, String price, String title, String description, String category, String pid) {
        String query = """
                       UPDATE product
                       SET [name] = ?, [image] = ?, price = ?, title = ?, [description] = ?, cateID = ?
                       WHERE id = ?""";
        try {
            conn = new DBContext().getConnection(); // Open connection
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setString(3, price);
            ps.setString(4, title);
            ps.setString(5, description);
            ps.setString(6, category);
            ps.setString(7, pid);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // Log error
        } finally {
            closeConnection(); // Always close connection
        }
    }
}
