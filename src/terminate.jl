# Terminate game server
# For security reason, this his is only available to an admin given by
# the user id from the DISCORDER_TRADING_GAME_ADMIN environment varialble.
function cmd_terminate(client, message)
    admin_id_str = get(ENV, "DISCORDER_TRADING_GAME_ADMIN", "")
    if admin_id_str === ""
        @warn "Non-admin user cannot terminate server"
        reply(client, message, "Only game server admin can do this")
        return nothing
    end
    admin_id = tryparse(Int, admin_id_str)
    if isnothing(admin_id)
        @warn "DISCORDER_TRADING_GAME_ADMIN is not an integer: $admin_id_str"
        return nothing
    end
    user_id = message.author.id
    if user_id == admin_id
        @info "Shutting down game server per admin request"
        reply(client, message, "Game server shutdown initiated")
        return BotExit()
    end
end
