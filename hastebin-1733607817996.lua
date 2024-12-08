-- Configuration des utilisateurs
local USERS = {
    ["Byvars.ETB"] = {password = "Cagne6631", role = "superadmin"},
    ["Toziol.ETB"] = {password = "titi", role = "admin"}
}

-- URL du dépôt GitHub
local GITHUB_REPO = "https://github.com/revederedstonne64/ETBnux.git"
local LOCAL_REPO_DIR = "ETBnux" -- Nom du dossier local pour cloner le dépôt

-- Fonction pour afficher le logo
local function displayLogo()
    term.clear()
    term.setCursorPos(1, 1)
    print("   ██████████████████████████   ")
    print("  ███ Meilleure Technologie ███ ")
    print(" ███       ETB.Corp         ███ ")
    print(" ███   Depuis 2000          ███ ")
    print("   ██████████████████████████   ")
    sleep(2) -- Affiche le logo pendant 2 secondes
    term.clear()
end

-- Vérifie si Internet est accessible
local function isInternetAvailable()
    if http then
        local success = http.checkURL("http://www.google.com")
        return success
    else
        return false
    end
end

-- Fonction pour cloner le dépôt GitHub
local function cloneGitHubRepo()
    if not isInternetAvailable() then
        print("Erreur : Connexion Internet non disponible.")
        return
    end

    if fs.exists(LOCAL_REPO_DIR) then
        print("Le dépôt existe déjà localement.")
        return
    end

    print("Clonage du dépôt GitHub...")
    local success = shell.run("git clone " .. GITHUB_REPO .. " " .. LOCAL_REPO_DIR)

    if success then
        print("Dépôt GitHub cloné avec succès dans le dossier " .. LOCAL_REPO_DIR)
    else
        print("Erreur lors du clonage du dépôt GitHub.")
    end
end

-- Fonction pour afficher le menu supplémentaire
local function showGitHubMenu(role)
    if role == "superadmin" then
        print("\nMenu GitHub :")
        print("1. Cloner le dépôt GitHub")
        print("2. Vérifier les mises à jour")
        write("> ")
        local choice = read()

        if choice == "1" then
            cloneGitHubRepo()
        elseif choice == "2" then
            print("Fonction de mise à jour à implémenter.")
        else
            print("Option invalide.")
        end
    else
        print("Permission refusée.")
    end
end

-- Fonction pour afficher les options en fonction du rôle
local function showMenu(role)
    print("\nBienvenue dans ETB Linux")
    print("Options disponibles :")
    print("1. Voir la propagande")
    print("2. Changer la propagande")

    if role == "superadmin" then
        print("3. Gérer les comptes employés")
        print("4. Configuration système")
        print("8. Menu GitHub")
    elseif role == "admin" then
        print("3. Gérer les comptes employés")
    end

    print("5. Quitter")
end

-- Fonction principale
local function main()
    displayLogo() -- Afficher le logo au lancement
    while true do
        print("Connexion à ETB Linux")
        write("Nom d'utilisateur : ")
        local username = read()
        write("Mot de passe : ")
        local password = read("*")

        if USERS[username] and USERS[username].password == password then
            local role = USERS[username].role
            while true do
                showMenu(role)
                write("> ")
                local choice = read()

                if choice == "1" then
                    print("Propagande actuelle : Bienvenue dans ETB.corp")
                elseif choice == "2" and role == "superadmin" then
                    print("Entrez une nouvelle propagande :")
                    local newText = read()
                    print("Nouvelle propagande ajoutée : " .. newText)
                elseif choice == "3" and (role == "superadmin" or role == "admin") then
                    print("Gestion des comptes employés (option fictive).")
                elseif choice == "4" and role == "superadmin" then
                    print("Configuration système (option fictive).")
                elseif choice == "8" and role == "superadmin" then
                    showGitHubMenu(role)
                elseif choice == "5" then
                    print("Déconnexion...")
                    break
                else
                    print("Option invalide.")
                end
            end
        else
            print("Nom d'utilisateur ou mot de passe incorrect.")
        end
    end
end

-- Lancer le programme
main()
