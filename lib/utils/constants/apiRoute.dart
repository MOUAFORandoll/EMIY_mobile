class ApiRoutes {
  static const POPULAR_ALL = '/produit/read/client';
  static const POPULAR_PRODUCT = '/produit/read/popular';
  static const INTEREST_PRODUCT = '/produit/read/interest';
  static const LINK_PRODUCT = '/link/produit/read';
  static const LINK_BOUTIQUE = '/link/boutique/read';
  static const CATEGORY_PRODUCT = '/category/read';
  static const CATEGORY = '/category/read/all';
  static const BOUTIQUE_FOR_CATEGORY = '/category/read/boutique';
  static const BOUTIQUE_IMAGE_UPDATE = '/boutique/image/new';
  static const BOUTIQUE_NEW = '/boutique/user/new';
  static const BOUTIQUE_FOR_UPDATE = '/boutique/update';
  static const BOUTIQUE_FOR_UPDATE_LOCALISATION = '/boutique/localisation';
  static const BOUTIQUE_FOR_USER = '/boutique/read/user';
  static const BOUTIQUE_READ_ALL = '/boutique/read/all';
  static const BOUTIQUE_READ_COMMANDE = '/commande/boutique/read';
  static const USER_READ_COMMANDE_PRODUIT = '/commande/produit/read/user';
  static const BOUTIQUE_READ_HCOMMANDE = '/commande/boutique/readH';
  static const BOUTIQUE_READ_PRODUIT = '/boutique/read/produit';
  static const UPDATE_USER = '/user/update';
  static const LOCATION_USER = '/user/location';
  static const USER = '/user/get';
  static const LIVREUR = '/livreur/read/ville';
  static const LIVRAISON_POINT = '/point_livraison/read';
  static const BUY = '/commande/newX';
  static const VERIFY = '/commande/verify';
  static const UPDATE_PRODUCT = '/produit/update';

  static const UPDATE_PRODUCT_IMAGE = '/produit/image/update';
  static const ADD_PRODUCT_IMAGE = '/produit/image/add';

  static const NEW_PRODUCT = '/produit/new';
  static const DESABLED_PRODUCT = '/produit/state';
  static const LOGIN = '/api/logins';
  static const Refresh = '/api/token/refresh';
  static const SIGNUP = '/api/user_plateforms';
  static const SEARCH = '/search';
  static const MODEPAIEMENT = '/modepaiement/read';

  static const TRANSACTION_READ = '/transaction/read';
  static const TRANSACTION_RETRAIT = '/transaction/retrait';
  static const TRANSACTION_DEPOT = '/compte/credit';
  static const VERIFY_DEPOT = '/compte/credit/verify';

  static const SHORT_READ_FORYOU = '/short/foryou/read';
  static const SHORT_READ_SUIVIS = '/short/suivis/read';
  static const SAVE_SHORT_USER_READ = '/short/user/read';
  static const SHORT_READ_UNIQUE = '/short/read/unique';
  static const SHORT_READ_BOUTIQUE = '/short/boutique/read';
  static const SHORT_NEW = '/short/new';
  static const SHORT_LIKE = '/like/short';
  static const SHORT_COMMENT = '/comment/short';
  static const SHORT_COMMENT_COMMENT = '/comment/comment/short';
  static const SHORT_COMMENT_LIKE = '/like/comment';
  static const LIKE_PRODUIT = '/like/produit';
  static const SUPPLEMENTAIRE_PRODUIT = '/produit/from/category';
  static const NOTAITON_BOUTIQUE = '/notation/boutique';
  static const TEST = '/test/scroll';
  static const NEW_NEGOCIATION = '/negociation/start';
  static const LIST_NEGOCIATION = '/negociation/list';
  static const LIST_MESSAGE_NEGOCIATION = '/negociation/message/list';
  static const NEW_MESSAGE_NEGOCIATION = '/negociation/message/new';

  static const ABONNEMENT = '/abonnement';
  static const ABONNEMENT_BOUTIQUE_USER = '/abonnement/user';
  static const ABONNEMENT_PRODUIT_USER = '/abonnement/produit/read';
  static const ABONNEMENT_BOUTIQUE = '/abonnement/boutique';

  static const LIST_MESSAGE_SC = '/communication/message/list';
  static const LIST_MESSAGE_NEW = '/communication/message/new';
  static const LIST_FIEUL = '/user/fieul';
  static const LIST_USER_BY = '/user/find';
  static const USER_IMAGE_UPDATE = '/user/image/new';
  static const LIST_NOTIFICATIONS = '/notifications';
  static const READ_NOTIFICATIONS = '/notifications/read';
  static const READ_SHORT_FOR_BOUTIQUE = '/short/for/boutique/read';
  static const HOME = '/home';
}
