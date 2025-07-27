package com.study.projectstudy.security

import com.study.projectstudy.repository.UserRepository
import io.jsonwebtoken.*
import io.jsonwebtoken.security.Keys
import org.springframework.stereotype.Component
import java.util.*
import javax.crypto.SecretKey

@Component
class JwtUtil {

    private val jwtSecret: SecretKey = Keys.secretKeyFor(SignatureAlgorithm.HS256)
    private val jwtExpirationMs = 86400000L

    fun generateToken(username: String, role: String): String {
        val now = Date()
        val expiryDate = Date(now.time + jwtExpirationMs)

        return Jwts.builder()
            .setSubject(username)
            .claim("role", role)
            .setIssuedAt(now)
            .setExpiration(expiryDate)
            .signWith(jwtSecret)
            .compact()
    }

    fun validateToken(token: String): Boolean {
        return try {
            Jwts.parserBuilder()
                .setSigningKey(jwtSecret)
                .build()
                .parseClaimsJws(token)
            true
        } catch (ex: JwtException) {
            false
        }
    }

    fun getUsernameFromToken(token: String): String {
        val claims = Jwts.parserBuilder()
            .setSigningKey(jwtSecret)
            .build()
            .parseClaimsJws(token)
            .body
        return claims.subject
    }
}
