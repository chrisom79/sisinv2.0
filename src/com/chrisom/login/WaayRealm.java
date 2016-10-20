package com.chrisom.login;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SaltedAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.realm.jdbc.JdbcRealm;

import com.chrisom.sisinv.dao.VendedorDAO;
import com.chrisom.sisinv.entity.Vendedor;

public class WaayRealm extends JdbcRealm {
	@Override
  protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
    // identify account to log to
    UsernamePasswordToken userPassToken = (UsernamePasswordToken) token;
    final String username = userPassToken.getUsername();

    if (username == null) {
      System.out.println("Username is null.");
      return null;
    }

    // read password hash and salt from db
    VendedorDAO dao = new VendedorDAO();
    final Vendedor user = dao.findVendedorByUser(username);

    if (user == null) {
      System.out.println("No account found for user [" + username + "]");
      return null;
    }

    // return salted credentials
    SaltedAuthenticationInfo info = new WaaySaltedAuthentificationInfo(username, user.getPassword(), user.getSalt());

    return info;
  }

}
