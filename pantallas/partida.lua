require "objetos/tronco"

local partida = {
    update = function(dt)
        -- lógica de la partida
        tiempo_partida = tiempo_partida + dt

        -- decidimos si debemos crear un nuevo tronco
        if tiempo_partida >= tiempo_creacion_siguiente_obstaculo then
            table.insert(obstaculos, nuevo_tronco(164, 56))
            tiempo_creacion_siguiente_obstaculo = tiempo_partida + rnd(tiempo_minimo_entre_obstaculos, tiempo_maximo_entre_obstaculos)
        end

        local indices_obstaculos_a_eliminar = {}    -- lista para guardar los índices de los obstáculos que se salen por la izquierda de la pantalla (los eliminaremos posteriormente)
        -- actualizamos los obstáculos (los movemos y comprobamos colisiones)
        for i, obstaculo in ipairs(obstaculos) do
            obstaculo.x = obstaculo.x - heroe.velocidad * dt
            -- si el obstáculos se sale por la izquierda, actualizamos los puntos e insertamos su índice en la lista indices_obstaculos_a_eliminar
            if obstaculo.x < -10 then
                puntos = puntos + 1
                table.insert(indices_obstaculos_a_eliminar, i)
            end
            -- comprobamos si el héroe y el obstáculo están colisionando
            if colisionando(heroe, obstaculo) then
                if puntos > high_score then
                    high_score = puntos
                end
                pantalla = "menu"
            end
        end

        -- eliminamos los obstáculos insertados previamente en la lista indices_obstaculos_a_eliminar
        for i=#indices_obstaculos_a_eliminar,1,-1 do
            table.remove(obstaculos, i)
        end
        heroe.update(dt)
    end,
    draw = function()
        -- dibujamos el frame de la partida
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(imagen_fondo, 0, 0)
        love.graphics.setColor(246, 214, 189, 255)  -- TODO: Investigar cómo cambiar correctamente el color del font para que respete la paleta
        love.graphics.setFont(font_hud)
        love.graphics.print(puntos, 100, 10)
        love.graphics.setColor(255, 255, 255)
        heroe.draw()
        heroe.draw_hitbox()

        -- dibujamos los obstáculos
        for i, obstaculo in ipairs(obstaculos) do
            obstaculo:draw()
            obstaculo:draw_hitbox()
        end

    end,
    se_ha_pulsado_una_tecla = function(tecla)
        -- salto del héroe
        if tecla == "space" then
            heroe.saltar()
        end
    end
}

return partida