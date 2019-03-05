//
//  APIConstants.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/5/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

extension Constants {
    struct API {
        static let baseURL = "http://data.fixer.io/api/"
        struct EndPoints{
            static let latestEndPoint = "latest"
        }

        struct Parameters {
            static let accessKey = "91c2c49f07767a130b3e7973feb957de"
            static let baseCurrency = "base"
            static let currencySymbols = "symbols"
        }

        struct JSONPayloadKeys {

            struct ServerSpecific {
                static let success = "success"
                static let timeStamp = "timestamp"
                static let date = "date"
            }

            struct APISpecific {
                static let base = "base"
                static let rates = "rates"
            }

            struct CurrencyIdentifiers {
                static let AED = "AED"
                static let AFN = "AFN"
                static let ALL = "ALL"
                static let AMD = "AMD"
                static let ANG = "ANG"
                static let AOA = "AOA"
                static let ARS = "ARS"
                static let AUD = "AUD"
                static let AWG = "AWG"
                static let AZN = "AZN"
                static let BAM = "BAM"
            }
//            AZN    1.930778
//            BAM    1.954017
//            BBD    2.26645
//            BDT    95.203102
//            BGN    1.956106
//            BHD    0.42687
//            BIF    2042.56813
//            BMD    1.132376
//            BND    1.529746
//            BOB    7.838187
//            BRL    4.275391
//            BSD    1.132942
//            BTC    0.000303
//            BTN    80.148371
//            BWP    12.055882
//            BYN    2.424768
//            BYR    22195.672976
//            BZD    2.282418
//            CAD    1.510279
//            CDF    1845.864522
//            CHF    1.133151
//            CLF    0.028365
//            CLP    746.729504
//            CNY    7.589668
//            COP    3501.99025
//            CRC    686.333155
//            CUC    1.132432
//            CUP    30.009456
//            CVE    110.174908
//            CZK    25.627312
//            DJF    201.256259
//            DKK    7.4618
//            DOP    57.374717
//            DZD    134.498468
//            EGP    19.864106
//            ERN    16.986458
//            ETB    31.938552
//            EUR    1
//            FJD    2.406701
//            FKP    0.860615
//            GBP    0.859171
//            GEL    3.023687
//            GGP    0.859205
//            GHS    6.256658
//            GIP    0.860637
//            GMD    56.072372
//            GNF    10329.136645
//            GTQ    8.729864
//            GYD    236.502849
//            HKD    8.889311
//            HNL    27.672099
//            HRK    7.431701
//            HTG    94.117013
//            HUF    315.639423
//            IDR    15998.154135
//            ILS    4.105633
//            IMP    0.859205
//            INR    80.137133
//            IQD    1351.048349
//            IRR    47681.061848
//            ISK    136.492074
//            JEP    0.859205
//            JMD    144.73136
//            JOD    0.803233
//            JPY    126.744654
//            KES    113.306629
//            KGS    78.960539
//            KHR    4529.049145
//            KMF    492.608037
//            KPW    1019.262625
//            KRW    1275.549123
//            KWD    0.344287
//            KYD    0.943537
//            KZT    426.043593
//            LAK    9718.930879
//            LBP    1708.783747
//            LKR    203.317152
//            LRD    183.171278
//            LSL    16.125534
//            LTL    3.343778
//            LVL    0.684997
//            LYD    1.570116
//            MAD    10.84672
//            MDL    19.379884
//            MGA    4006.885309
//            MKD    61.647918
//            MMK    1722.318332
//            MNT    2983.250923
//            MOP    9.154186
//            MRO    404.278374
//            MUR    38.570315
//            MVR    17.50751
//            MWK    825.107166
//            MXN    21.839693
//            MYR    4.617834
//            MZN    71.031799
//            NAD    16.120198
//            NGN    408.243822
//            NIO    37.251924
//            NOK    9.819909
//            NPR    128.420778
//            NZD    1.66664
//            OMR    0.436015
//            PAB    1.132376
//            PEN    3.746313
//            PGK    3.821789
//            PHP    59.128252
//            PKR    158.302744
//            PLN    4.303412
//            PYG    6888.965067
//            QAR    4.123208
//            RON    4.742967
//            RSD    118.021795
//            RUB    74.50722
//            RWF    1019.194727
//            SAR    4.247413
//            SBD    9.204127
//            SCR    15.491943
//            SDG    53.913948
//            SEK    10.586396
//            SGD    1.534344
//            SHP    1.495829
//            SLL    9880.471432
//            SOS    656.810542
//            SRD    8.445711
//            STD    23838.378821
//            SVC    9.906973
//            SYP    583.202637
//            SZL    16.129233
//            THB    36.058348
//            TJS    10.677253
//            TMT    3.963513
//            TND    3.442369
//            TOP    2.561845
//            TRY    6.085974
//            TTD    7.688706
//            TWD    34.921377
//            TZS    2656.121881
//            UAH    30.383402
//            UGX    4186.042277
//            USD    1.132432
//            UYU    37.019507
//            UZS    9505.636888
//            VEF    11.310169
//            VND    26272.88221
//            VUV    129.129462
//            WST    2.938316
//            XAF    655.315754
//            XAG    0.07509
//            XAU    0.000881
//            XCD    3.060455
//            XDR    0.813689
//            XOF    655.383676
//            XPF    119.154198
//            YER    283.449572
//            ZAR    16.052703
//            ZMK    10193.24633
//            ZMW    13.603892
//            ZWL    365.045225
        }
    }
}
