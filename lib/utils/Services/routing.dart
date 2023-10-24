import 'package:EMIY/Views/BoutiqueUser/BoutiqueBuyView.dart';
import 'package:EMIY/Views/BoutiqueUser/BoutiqueNewView.dart';
import 'package:EMIY/Views/BoutiqueUser/BoutiqueUserView.dart';
import 'package:EMIY/Views/BoutiqueUser/CommadesBoutiqueUserView.dart';
import 'package:EMIY/Views/BoutiqueUser/ShortBoutiqueView.dart';
import 'package:EMIY/Views/Short/ShortView.dart';
import 'package:EMIY/Views/UsersMange/UserAbonnementView.dart';
import 'package:EMIY/Views/Search/SearchView.dart';
import 'package:EMIY/Views/Link/BoutiqueViewForLink.dart';
import 'package:EMIY/Views/Space/MySpace.dart';
import 'package:EMIY/Views/Space/Negociation/ListNegociationView.dart';
import 'package:EMIY/Views/Space/Negociation/NegociationView.dart';
import 'package:EMIY/Views/Link/ProduitViewForLink.dart';
import 'package:EMIY/Views/Parrainnage/ParrainnageView.dart';
import 'package:EMIY/Views/Produit/PreferenceView.dart';
import 'package:EMIY/Views/Shopping/PaiementView.dart';
import 'package:EMIY/Views/UsersMange/InteretsView.dart';
import 'package:EMIY/Views/UsersMange/ServiceClientView.dart';
import 'package:EMIY/Views/UsersMange/WalletView.dart';
import 'package:EMIY/Views/BoutiqueUser/HistroriqueCBUView.dart';
import 'package:EMIY/Views/BoutiqueUser/manageBoutiqueUserView.dart';
import 'package:EMIY/Views/BoutiqueUser/produitBoutiqueUserView.dart';
import 'package:EMIY/Views/CategoryBoutique/BoutiqueCategoryView.dart';
import 'package:EMIY/Views/CategoryBoutique/BoutiqueView.dart';
import 'package:EMIY/Views/Commandes/CommandeView.dart';
import 'package:EMIY/Views/Commandes/ProduitForCommande.dart';
import 'package:EMIY/Views/ComplementView/OnboardingScreen.dart';
import 'package:EMIY/Views/FirstScreen.dart';
import 'package:EMIY/Views/ComplementView/SplashScreen.dart';
import 'package:EMIY/Views/Home/HomeView.dart';
import 'package:EMIY/Views/Home/ListBoutiquesView.dart';
import 'package:EMIY/Views/Home/ListProduitsView.dart';
import 'package:EMIY/Views/Produit/ProduitView.dart';
import 'package:EMIY/Views/Shopping/BuyShoopingCart.dart';
import 'package:EMIY/Views/Shopping/ShoppingView.dart';
import 'package:EMIY/Views/Shopping/ShoppingViewNext.dart';
import 'package:EMIY/Views/UsersMange/HelpView.dart';
import 'package:EMIY/Views/UsersMange/PolitiqueView.dart';
import 'package:EMIY/Views/UsersMange/RegisterScreen.dart';
import 'package:EMIY/Views/UsersMange/SettingView.dart';
import 'package:EMIY/Views/UsersMange/UserManageView.dart';
import 'package:EMIY/Views/UsersMange/forgotPassword.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/utils/Services/core.dart';
import 'package:flutter/material.dart';
import 'package:EMIY/Views/UsersMange/LoginScreen.dart';
import 'package:EMIY/Views/ComplementView/AboutUsView.dart';
// import 'package:EMIY/Views/Home/AcheterBillet.dart';
import 'package:get/get.dart';

import '../../test.dart';

var transitionX = Transition.leftToRight;

class AppRoutes {
  static final pages = [
    GetPage(
        name: AppLinks.FIRST,
        page: () {
          secondInit();
          return FirstScreen();
        },
        transition: transitionX),
    GetPage(
        name: AppLinks.LOGIN,
        page: () => LoginScreen(),
        transition: transitionX),
    GetPage(
        name: AppLinks.HOME,
        children: [],
        page: () => HomeView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.REGISTER,
        page: () => RegisterScreen(),
        transition: transitionX),
    GetPage(
      name: AppLinks.FORGOT,
      page: () => ForgotPassordScreen(),
      transition: transitionX,
    ),
    GetPage(
        name: AppLinks.CART,
        page: () => ShoppingView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.BUYSHOP,
        page: () => BuyShoopingCart(),
        transition: transitionX),
    // GetPage(name: AppLinks.ABOUTUS, page: () => AboutUsScreen(),  transition:transitionX),
    GetPage(
        name: AppLinks.SPLASHSCREEN,
        page: () => SplashScreenPage(),
        transition: transitionX),
    GetPage(name: AppLinks.TEST, page: () => Test()),
    GetPage(
        name: AppLinks.ONBOARDING,
        page: () => OnBoardingView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.PRODUCT,
        // ignore: top_level_function_literal_block
        page: () {
          var index = Get.parameters['index'];
          ProduitModel produit = Get.find<GeneralController>()
              .getProduit(Get.parameters['codeProduit']);

          return ProduitView(index: int.parse(index!), produit: produit);
        },
        transition: transitionX),
    GetPage(
        name: AppLinks.PRODUCT_FOR_COMMANDE,
        // ignore: top_level_function_literal_block
        page: () {
          var id = Get.parameters['id'];
          var code = Get.parameters['code'];
          return ProduitForCommande(id: int.parse(id!), code: code!);
        },
        transition: transitionX),
    GetPage(
        name: AppLinks.BOUTIQUE,
        // ignore: top_level_function_literal_block
        page: () {
          return BoutiqueView();
        },
        transition: transitionX),
    GetPage(
        name: AppLinks.BOUTIQUE_FOR_CATEGORY,
        page: () => BoutiqueCategoryView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.PRODUCT_FOR_BOUTIQUE,
        page: () => ProduitBoutiqueUserView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.COMMANDE_FOR_BOUTIQUE,
        page: () => CommandesBoutiqueUserView(),
        transition: transitionX),

    GetPage(
        name: AppLinks.COMMANDE_FOR_USER,
        page: () => CommandeView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.HISTORIQUE_FOR_BOUTIQUE,
        page: () => HistroriqueCBUView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.MANAGE_FOR_BOUTIQUE,
        page: () => ManageBoutiqueUserView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.BOUTIQUE_USER,
        page: () {
          Get.find<BoutiqueController>().getListProduitForBoutique();
          return BoutiqueUserView();
        },
        transition: transitionX),
    GetPage(
        name: AppLinks.SHOPNEXT,
        page: () => ShoppingViewNext(),
        transition: transitionX),

    GetPage(
        name: AppLinks.BOUTIQUE_READ_ALL,
        page: () => ListBoutiquesView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.WALLET,
        page: () => WalletView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.PRODUCT_VIEW_BY_HOME,
        page: () => ListProduitsView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.SETTING,
        page: () => SettingView(),
        transition: transitionX),

    GetPage(
        name: AppLinks.BOUTIQUE_NEW,
        page: () => BoutiqueNewView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.BOUTIQUE_LOYER,
        page: () => BoutiqueBuyView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.POLITIQUE,
        page: () => PolitiqueView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.POLITIQUE,
        page: () => PolitiqueView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.HELP, page: () => HelpView(), transition: transitionX),

    GetPage(
        name: AppLinks.SHORT, page: () => ShortView(), transition: transitionX),
    GetPage(
        name: AppLinks.SHORT_BOUTIQUE,
        page: () => ShortBoutiqueView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.BUYVIEW,
        page: () => PaiementView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.USERVIEW,
        page: () => UserManageView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.NEGOCIATION_NEW,
        page: () => NegociationView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.NEGOCIATION_LIST,
        page: () => ListNegociationView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.ABONNEMENT,
        page: () => UserAbonnementView(),
        transition: transitionX),
    // GetPage(
    //     name: AppLinks.SERVICE_CLIENT,
    //     page: () => ServiceClientView(),
    //     transition: transitionX),
    GetPage(
        name: AppLinks.PRODUCT_FOR_LINK,
        page: () => ProduitViewForLink(),
        transition: transitionX),
    GetPage(
        name: AppLinks.BOUTIQUE_FOR_LINK,
        page: () => BoutiqueViewForLink(),
        transition: transitionX),
    GetPage(
        name: AppLinks.BOUTIQUE_FOR_LINK,
        page: () => BoutiqueViewForLink(),
        transition: transitionX),
    GetPage(
        name: AppLinks.FIEU_LIST,
        page: () => ParrainnageView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.PREFERENCE_CLIENT,
        page: () => PreferenceView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.NOTIFICATION,
        page: () => MySpace(),
        transition: transitionX),
    GetPage(
        name: AppLinks.SEARCH,
        page: () => SearchView(),
        transition: transitionX),
    GetPage(
        name: AppLinks.INTERET,
        page: () => InteretsView(),
        transition: transitionX),
  ];
}

class AppLinks {
  static const String PREFERENCE_CLIENT = "/preference_client";
  static const String SERVICE_CLIENT = "/service_client";
  static const String ABONNEMENT = "/abonnement";
  static const String SHORT = "/short";
  static const String INTERET = "/interet";
  static const String SHORT_BOUTIQUE = "/shortboutique";
  static const String PRODUCT_FOR_COMMANDE = "/pfc";
  static const String PRODUCT_FOR_LINK = "/pflink";
  static const String PRODUCT_VIEW_BY_HOME = "/pvbh";
  static const String BOUTIQUE_FOR_LINK = "/bflink";
  static const String BOUTIQUE = "/boutique";
  static const String BOUTIQUE_NEW = "/boutique/new";
  static const String BOUTIQUE_LOYER = "/boutique/loyer";
  static const String POLITIQUE = "/politique";
  static const String HELP = "/help";
  static const String SEARCH = "/search";
  static const String MANAGE_FOR_BOUTIQUE = "/mfb";
  static const String WALLET = "/cb";
  static const String SETTING = "/setting";
  static const String HISTORIQUE_FOR_BOUTIQUE = "/hfb";
  static const String COMMANDE_FOR_BOUTIQUE = "/cfb";
  static const String COMMANDE_FOR_USER = "/cfu";
  static const String PRODUCT_FOR_BOUTIQUE = "/pfb";
  static const String BUYSHOP = "/buyShop";
  static const String SHOPNEXT = "/shop";
  static const String TEST = "/TEST";
  static const String LOGIN = "/login";
  static const String HOME = "/home";
  static const String REGISTER = "/register";
  static const String ABOUTUS = "/aboutus";
  static const String FORGOT = "/forgot";
  static const String FIRST = "/first";
  static const String CART = "/cart";
  static const String SPLASHSCREEN = "/splashscreen";
  static const String ONBOARDING = "/onboarding";
  static const String PRODUCT = "/produit";
  static const String BOUTIQUE_FOR_CATEGORY = "/bfc";
  static const String BOUTIQUE_READ_ALL = "/bra";
  static const String PRODUCT_READ_ALL = "/pra";
  static const String BUYVIEW = "/buyview";
  static const String USERVIEW = "/userview";
  static const String BOUTIQUE_USER = "/boutique/user";
  static const String NEGOCIATION_NEW = "/negociation/new";
  static const String NEGOCIATION_LIST = "/negociation/list";
  static const String FIEU_LIST = "/fieul/list";
  static const String NOTIFICATION = "/notifications";
}

// <?php

// namespace App\Controller;

// use App\Entity\Boutique;
// use App\Entity\BoutiqueObject;
// use App\Entity\Category;
// use App\Entity\Localisation;
// use App\Entity\ModePaiement;
// use App\Entity\ProduitObject;
// use App\Entity\Short;
// use App\Entity\User;
// use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
// use Symfony\Component\HttpFoundation\JsonResponse;
// use Symfony\Component\HttpFoundation\Response;
// use Symfony\Component\Routing\Annotation\Route;
// use Symfony\Component\HttpFoundation\Request;

// use FFMpeg\FFMpeg;
// use FFMpeg\Format\Video\X264;

// use FFI\Exception;
// use Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface;
// use Symfony\Contracts\HttpClient\Exception\DecodingExceptionInterface;
// use Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface;
// use Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface;
// use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;
// use Symfony\Component\String\Slugger\SluggerInterface;

// use Doctrine\ORM\EntityManagerInterface;
// use Symfony\Contracts\HttpClient\HttpClientInterface;
// use App\FunctionU\MyFunction;
// use Symfony\Component\HttpFoundation\File\Exception\FileException;

// class ShortController extends AbstractController
// {
//     private $em;
//     private $clientWeb;
//     private $myFunction;
//     private $FFMpeg;
//     private $X264;
//     public function __construct(
//         EntityManagerInterface $em,
//         HttpClientInterface $clientWeb,
//         MyFunction
//         $myFunction,
//         FFMpeg $FFMpeg,
//         X264 $X264

//     ) {
//         $this->X264 = $X264;
//         $this->FFMpeg = $FFMpeg;
//         $this->em = $em;
//         $this->myFunction = $myFunction;

//         $this->clientWeb = $clientWeb;
//     }

//     /**
//      * @Route("/short/read", name="ShortRead", methods={"GET"})
//      * @param Request $request
//      * @return JsonResponse
//      * @throws ClientExceptionInterface
//      * @throws DecodingExceptionInterface
//      * @throws RedirectionExceptionInterface
//      * @throws ServerExceptionInterface
//      * @throws TransportExceptionInterface
//      * @throws \Exception
//      *
//      *
//      * @param array $data doit contenir la  la keySecret du
//      *
//      *
//      */
//     public function ShortRead(Request $request)
//     {

//         // $typeCompte = $AccountEntityManager->getRepository(TypeCompte::class)->findOneBy(['id' => 1]);

//         $possible = false;

//         $serializer = $this->get('serializer');

//         $lShortF = [];

//         $lShort = $this->em->getRepository(Short::class)->findAll();
//         foreach ($lShort as $short) {

//             $shortF =  [

//                 'id' => $short->getId(),
//                 'titre' => $short->getTitre() ?? "Aucun",
//                 'description' => $short->getDescription() ?? "Aucun",
//                 'status' => $short->isStatus(),
//                 'src' => /*  $_SERVER['SYMFONY_APPLICATION_DEFAULT_ROUTE_SCHEME'] */ 'http' . '://' . $_SERVER['HTTP_HOST'] . '/videos/shorts/' . $short->getSrc(),
//                 'date' =>
//                 date_format($short->getDateCreated(), 'Y-m-d H:i'),

//             ];
//             array_push($lShortF, $shortF);
//         }

//         return
//             new JsonResponse(
//                 [
//                     'data'
//                     =>  $lShortF,

//                 ],
//                 200
//             );
//     }

//     /**
//      * @Route("/short/new", name="ShortNew", methods={"POST"})
//      * @param Request $request
//      * @return JsonResponse
//      * @throws ClientExceptionInterface
//      * @throws DecodingExceptionInterface
//      * @throws RedirectionExceptionInterface
//      * @throws ServerExceptionInterface
//      * @throws TransportExceptionInterface
//      * @throws \Exception
//      *
//      *
//      * @param array $data doit contenir la  la keySecret du
//      *
//      *
//      */
//     public function ShortNew(Request $request, SluggerInterface $slugger)
//     {

//         // $typeCompte = $AccountEntityManager->getRepository(TypeCompte::class)->findOneBy(['id' => 1]);

//         $possible = false;

//         $serializer = $this->get('serializer');

//         $data = [

//             'titre' => $request->get('titre'),
//             'description' => $request->get('description'),

//             'codeBoutique' => $request->get('codeBoutique'),
//         ];

//         if (
//             empty($data['titre']) || empty($data['description'])

//             || empty($data['codeBoutique'])
//         ) {
//             return new JsonResponse(
//                 [
//                     'message' => 'Verifier votre requette'
//                 ],
//                 400
//             );
//         }

//         $titre = $data['titre'];
//         $description = $data['description'];

//         $boutique = $this->em->getRepository(Boutique::class)->findOneBy(['codeBoutique' => $data['codeBoutique']]);

//         $file = $request->files->get('file');

//         if ($file) {
//             $originalFilenameData = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
//             // this is needed to safely include the file name as part of the URL
//             $safeFilenameData = $slugger->slug($originalFilenameData);
//             $newFilenameData =
//                 $this->myFunction->getUniqueNameProduit() . '.' . $file->guessExtension();
//             // Move the file to the directory where brochures are stored
//             try {
//                 $ffmpeg =
//                     $this->FFMpeg::create();

//                 // Ouverture de la vidéo avec FFMpeg
//                 $video = $ffmpeg->open($file->getPathname());
//                 $video = $ffmpeg->open($file->getPathname());
//                 $format = $this->X264;
//                 // $format->setAudioCodec("aac");
//                 // $format->setVideoCodec("libx264");
//                 // $format->setPixelFormat("yuv420p");
//                 $video->save($format, $file->getPathname() . '.mp4');
//                 $file->move(
//                     $this->getParameter('shorts_object'),
//                     $newFilenameData
//                 );
//                 $short = new Short();
//                 $short->setSrc($newFilenameData);
//                 $short->setTitre($titre);
//                 $short->setDescription(
//                     $description
//                 );
//                 $short->setBoutique($boutique);
//                 $this->em->persist($short);

//                 $imagePresent = true;
//             } catch (FileException $e) {
//                 return
//                     new JsonResponse([

//                         'status' =>   false,
//                         'message' =>   'Vos fichiers ne sont pas valides'

//                     ], 203);
//             }
//         }

//         $this->em->flush();

//         return
//             new JsonResponse(
//                 [
//                     'message'
//                     =>  'success'
//                 ],
//                 200
//             );
//     }
// }
