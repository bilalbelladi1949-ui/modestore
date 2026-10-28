# ModeStore — boutique de seconde main

Site statique prêt à héberger sur Netlify, Vercel ou GitHub Pages, avec catalogue, filtres, panier et commande WhatsApp. Pour que les produits et photos soient partagés entre tous les visiteurs, connecte-le à Supabase.

## 1. Configurer Supabase (gratuit pour commencer)
1. Crée un projet sur https://supabase.com/
2. Dans **SQL Editor**, colle tout le contenu de `schema.sql`, puis clique **Run**.
3. Va dans **Authentication → Users** et crée ton utilisateur administrateur. N'active pas l'inscription publique.
4. Va dans **Project Settings → API** (ou Connect) et copie l'URL du projet et la clé **anon/public**.
5. Ouvre `index.html` dans un éditeur de texte et remplace :
   - `YOUR_SUPABASE_URL` par l'URL Supabase (ex. `https://xxxx.supabase.co`)
   - `YOUR_SUPABASE_ANON_KEY` par la clé anon/public.
   - `212600000000` par ton numéro WhatsApp marocain, sans `+`, espaces ou tirets (ex. `2126XXXXXXXX`).
6. Enregistre le fichier. Ne mets JAMAIS la clé `service_role` dans le site.

## 2. Publier le site
### Option simple : Netlify
1. Va sur https://app.netlify.com/drop
2. Dézippe le projet sur ton ordinateur.
3. Glisse le dossier qui contient `index.html` et `schema.sql` dans la zone de dépôt Netlify. (Si l'interface n'accepte pas le dossier, glisse `index.html` seul pour publier l'interface; conserve `schema.sql` pour la configuration.)
4. Netlify te donne une URL publique. Tu peux ensuite connecter un nom de domaine dans les réglages du site.

Tu peux aussi importer le dossier dans GitHub puis le déployer sur Netlify/Vercel.

## 3. Utiliser le site
- Les visiteurs filtrent les articles, les ajoutent au panier et envoient une commande préremplie sur WhatsApp.
- Pour gérer les articles, connecte-toi dans la section **Gestion** avec le compte Supabase créé plus haut.
- L'admin peut ajouter/modifier/supprimer les articles et téléverser des photos.
- Change la langue avec le bouton **دارجة / Français**.
- Les commandes et paiements ne sont pas encaissés automatiquement sur le site : la confirmation se fait avec toi sur WhatsApp.

## Important
- Sans configuration Supabase, le site affiche des produits de démonstration et la gestion en ligne n'est pas activée.
- La clé anon/public est prévue pour être visible dans le navigateur; la sécurité repose sur les politiques RLS du fichier `schema.sql` et l'accès administrateur. Ne crée pas de politique qui permet aux visiteurs anonymes de modifier les produits.
- Les produits de démonstration sont uniquement des exemples : supprime-les en ajoutant tes vrais produits dans l'espace admin une fois Supabase connecté.
- Teste l'ajout, la modification, la suppression, l'affichage des photos et le panier avant de partager ton lien.
