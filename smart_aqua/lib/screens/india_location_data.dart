// india_location_data.dart
// Hierarchical India location data: State → District → SubDistrict (optional) → Water Bodies

class IndiaLocationData {
  static List<String> getStates() => _data.keys.toList()..sort();

  static List<String> getDistricts(String state) {
    final d = _data[state];
    if (d == null) return [];
    return d.keys.toList()..sort();
  }

  static List<String> getSubDistricts(String state, String district) {
    final d = _data[state]?[district];
    if (d == null) return [];
    final sub = d['subDistricts'];
    if (sub == null) return [];
    return (sub as Map<String, dynamic>).keys.toList()..sort();
  }

  static List<String> getWaterBodies(String state, String district,
      [String? subDistrict]) {
    final d = _data[state]?[district];
    if (d == null) return [];
    if (subDistrict != null) {
      final sub = d['subDistricts']?[subDistrict];
      return List<String>.from(sub ?? []);
    }
    return List<String>.from(d['waterBodies'] ?? []);
  }

  static final Map<String, Map<String, Map<String, dynamic>>> _data = {
    // ── TAMIL NADU ──────────────────────────────────────────────────────────
    'Tamil Nadu': {
      'Chennai': {
        'subDistricts': {
          'Chennai North': [
            'Pulicat Lake', 'Ennore Creek', 'Kosasthalaiyar River',
            'Buckingham Canal (North)', 'Basin Bridge Canal'
          ],
          'Chennai South': [
            'Adyar River', 'Kovalam Lake', 'Pallikaranai Marshland',
            'Muttukadu Backwaters', 'Buckingham Canal (South)'
          ],
          'Chennai Central': [
            'Cooum River', 'Buckingham Canal', 'Otteri Nullah'
          ],
          'Chennai West': [
            'Chembarambakkam Lake', 'Puzhal Lake', 'Ambattur Lake',
            'Porur Lake'
          ],
          'Chennai East': [
            'Ennore Creek', 'Manali Backwaters', 'Pulicat Lake Extension'
          ],
          'Avadi': [
            'Puzhal Lake (Red Hills Reservoir)', 'Avadi Lake',
            'Ambattur Lake', 'Retteri Lake'
          ],
          'Tambaram': [
            'Mudichur Lake', 'Perungalathur Lake', 'Chitlapakkam Lake',
            'Nanmangalam Lake'
          ],
          'Sholinganallur': [
            'Pallikaranai Marshland', 'Perumbakkam Lake',
            'Sholinganallur Lake', 'Madipakkam Lake'
          ],
        }
      },
      'Coimbatore': {
        'subDistricts': {
          'Coimbatore North': [
            'Siruvani River', 'Pillur Dam', 'Bhavani River'
          ],
          'Coimbatore South': [
            'Noyyal River', 'Krishnagiri Dam', 'Singanallur Lake',
            'Sulur Lake'
          ],
          'Pollachi': [
            'Aliyar Dam', 'Parambikulam Dam', 'Anamalai River', 'Aliyar River'
          ],
          'Mettupalayam': ['Bhavani River', 'Moyar River', 'Lower Bhavani Dam'],
        }
      },
      'Madurai': {
        'subDistricts': {
          'Madurai North': [
            'Vaigai River', 'Vandiyur Lake', 'Mariamman Teppakulam'
          ],
          'Madurai South': ['Vaigai River', 'Alagarkovil Pond'],
          'Melur': ['Vaigai River', 'Melur Lake'],
          'Tirumangalam': ['Vaigai River', 'Tirumangalam Lake'],
        }
      },
      'Tiruchirappalli': {
        'waterBodies': [
          'Cauvery River', 'Kollidam River', 'Grand Anicut Canal',
          'Uyyakondan Canal', 'Srirangam Island Waters'
        ],
      },
      'Salem': {
        'waterBodies': [
          'Mettur Dam', 'Thirumanimuthar River', 'Mallur Reservoir',
          'Molapalayam Lake'
        ],
      },
      'Tirunelveli': {
        'waterBodies': [
          'Thamirabarani River', 'Papanasam Dam', 'Manimuthar Dam',
          'Gadana River'
        ],
      },
      'Vellore': {
        'waterBodies': [
          'Palar River', 'Vellore Fort Moat', 'Ambur Lake', 'Sathuvachari Lake'
        ],
      },
      'Erode': {
        'waterBodies': [
          'Cauvery River', 'Bhavani River', 'Lower Bhavani Project',
          'Sathyamangalam Lake'
        ],
      },
      'Thanjavur': {
        'waterBodies': [
          'Cauvery River', 'Grand Anicut', 'Veeranam Lake', 'Kollidam River'
        ],
      },
      'Tirupur': {
        'waterBodies': [
          'Noyyal River', 'Amaravathi River', 'Tirupur Reservoir',
          'Orathupalayam Dam'
        ],
      },
      'Kancheepuram': {
        'waterBodies': [
          'Palar River', 'Cheyyar River', 'Kancheepuram Tank'
        ],
      },
      'Chengalpattu': {
        'waterBodies': [
          'Palar River', 'Chembarambakkam Lake', 'Kovalam Backwaters',
          'Maduranthagam Lake'
        ],
      },
      'Villupuram': {
        'waterBodies': [
          'Gingee River', 'Villupuram Lake', 'South Pennar River'
        ],
      },
      'Cuddalore': {
        'waterBodies': [
          'Gadilam River', 'Vellar River', 'Paravanar River', 'Uppanar River'
        ],
      },
      'Nagapattinam': {
        'waterBodies': [
          'Cauvery River', 'Kollidam River', 'Vellar River', 'Bay of Bengal Coast'
        ],
      },
      'Ramanathapuram': {
        'waterBodies': [
          'Palk Bay', 'Gulf of Mannar', 'Pamban Channel', 'Rameswaram Island Waters'
        ],
      },
      'Thoothukudi': {
        'waterBodies': [
          'Gulf of Mannar', 'Thamirabarani River', 'Krishnapuram Lake'
        ],
      },
      'Dindigul': {
        'waterBodies': [
          'Vaigai River', 'Kodaikanal Lake', 'Manjalar Dam', 'Perumal River'
        ],
      },
      'Nilgiris': {
        'waterBodies': [
          'Pykara Lake', 'Emerald Reservoir', 'Ooty Lake',
          'Avalanche Lake', 'Bhavani River (Source)'
        ],
      },
      'Dharmapuri': {
        'waterBodies': [
          'Cauvery River', 'Krishnagiri Reservoir', 'Agara Lake'
        ],
      },
      'Krishnagiri': {
        'waterBodies': [
          'Krishnagiri Reservoir', 'Cauvery River', 'Thoppur Lake', 'Barur Lake'
        ],
      },
      'Tiruvannamalai': {
        'waterBodies': [
          'Cheyyar River', 'Sathanur Reservoir', 'Thenpennai River'
        ],
      },
      'Pudukottai': {
        'waterBodies': [
          'Vellar River', 'Amaravathi River', 'Manimuktha River'
        ],
      },
      'Sivaganga': {
        'waterBodies': ['Vaigai River', 'Sivaganga Lake', 'Piranmalai Lake'],
      },
      'Namakkal': {
        'waterBodies': [
          'Cauvery River', 'Tirumanimuthar River', 'Namakkal Lake'
        ],
      },
      'Karur': {
        'waterBodies': ['Cauvery River', 'Amaravathi River', 'Karur Tank'],
      },
      'Ariyalur': {
        'waterBodies': ['Cauvery River', 'Kollidam River', 'Ariyalur Lake'],
      },
      'Perambalur': {
        'waterBodies': ['Vellar River', 'Perambalur Lake'],
      },
      'Virudhunagar': {
        'waterBodies': [
          'Vaigai River', 'Virudhunagar Lake', 'Arjuna River'
        ],
      },
      'Tirupathur': {
        'waterBodies': ['Palar River', 'Cheyyar River', 'Tirupathur Lake'],
      },
      'Ranipet': {
        'waterBodies': ['Palar River', 'Arcot Lake', 'Palar Canal'],
      },
      'Kallakurichi': {
        'waterBodies': ['Gomukhi River', 'Sankarapuram Lake', 'Muppar River'],
      },
      'Tenkasi': {
        'waterBodies': [
          'Thamirabarani River', 'Kallar River', 'Courtallam Falls'
        ],
      },
    },

    // ── MAHARASHTRA ─────────────────────────────────────────────────────────
    'Maharashtra': {
      'Mumbai City': {
        'subDistricts': {
          'South Mumbai': [
            'Mahim Bay', 'Arabian Sea Coast', 'Ulhas River Estuary'
          ],
          'North Mumbai': ['Vihar Lake', 'Tulsi Lake', 'Powai Lake'],
          'Central Mumbai': [
            'Mithi River', 'Mahim Creek', 'Dharavi Creek'
          ],
          'Western Suburbs': ['Vasai Creek', 'Gorai Creek', 'Versova Creek'],
          'Eastern Suburbs': ['Thane Creek', 'Mankhurd Creek'],
        }
      },
      'Mumbai Suburban': {
        'subDistricts': {
          'Andheri': ['Mithi River', 'Aarey Colony Streams'],
          'Borivali': ['Tulsi Lake', 'Vihar Lake', 'Poisar River'],
          'Kurla': ['Mithi River', 'Thane Creek'],
          'Malad': ['Malad Creek', 'Poisar River'],
        }
      },
      'Pune': {
        'subDistricts': {
          'Pune City': ['Mula River', 'Mutha River', 'Mula-Mutha River'],
          'Pimpri-Chinchwad': [
            'Pavana River', 'Indrayani River', 'Mula River'
          ],
          'Haveli': ['Bhima River', 'Nira River', 'Vel River'],
          'Mulshi': ['Mulshi Lake', 'Mula River', 'Pavana Lake'],
          'Maval': ['Pavana Dam', 'Indrayani River', 'Pawna Lake'],
          'Baramati': ['Bhima River', 'Nira River'],
        }
      },
      'Nashik': {
        'waterBodies': [
          'Godavari River', 'Gangapur Dam', 'Palkhed Dam', 'Girna River'
        ],
      },
      'Nagpur': {
        'waterBodies': [
          'Nag River', 'Kanhan River', 'Ambazari Lake',
          'Futala Lake', 'Gorewada Lake'
        ],
      },
      'Aurangabad': {
        'waterBodies': [
          'Kham River', 'Jayakwadi Dam', 'Harsul Lake', 'Salim Ali Lake'
        ],
      },
      'Thane': {
        'waterBodies': [
          'Ulhas River', 'Thane Creek', 'Masunda Lake', 'Upvan Lake'
        ],
      },
      'Solapur': {
        'waterBodies': [
          'Bhima River', 'Ekruk Dam', 'Ujjani Reservoir'
        ],
      },
      'Kolhapur': {
        'waterBodies': [
          'Panchganga River', 'Rankala Lake', 'Radhanagari Dam'
        ],
      },
      'Raigad': {
        'waterBodies': [
          'Kundalika River', 'Patalganga River', 'Amba River', 'Arabian Sea'
        ],
      },
      'Amravati': {
        'waterBodies': [
          'Wardha River', 'Purna River', 'Upper Wardha Dam'
        ],
      },
      'Satara': {
        'waterBodies': [
          'Krishna River', 'Koyna River', 'Koyna Dam', 'Urmodi River'
        ],
      },
      'Sangli': {
        'waterBodies': [
          'Krishna River', 'Warna River', 'Dudhganga River'
        ],
      },
      'Nanded': {
        'waterBodies': [
          'Godavari River', 'Vishnupuri Dam', 'Manair River'
        ],
      },
      'Latur': {
        'waterBodies': ['Manjra River', 'Tirru River'],
      },
      'Chandrapur': {
        'waterBodies': [
          'Wardha River', 'Irai Dam', 'Ghonsa River'
        ],
      },
      'Jalgaon': {
        'waterBodies': ['Tapi River', 'Girna River', 'Hathnur Dam'],
      },
      'Dhule': {
        'waterBodies': ['Tapi River', 'Burai River'],
      },
      'Nandurbar': {
        'waterBodies': ['Tapi River', 'Sardar Sarovar Reservoir'],
      },
      'Akola': {
        'waterBodies': ['Morna River', 'Purna River', 'Wan Dam'],
      },
      'Buldhana': {
        'waterBodies': [
          'Penganga River', 'Nalganga Dam', 'Khadakpurna Dam'
        ],
      },
      'Yavatmal': {
        'waterBodies': ['Wardha River', 'Penganga River', 'Painganga River'],
      },
      'Palghar': {
        'waterBodies': ['Surya River', 'Vaitarna River', 'Tansa Lake'],
      },
      'Sindhudurg': {
        'waterBodies': [
          'Terekhol River', 'Karli River', 'Arabian Sea Coast'
        ],
      },
    },

    // ── KARNATAKA ────────────────────────────────────────────────────────────
    'Karnataka': {
      'Bengaluru Urban': {
        'subDistricts': {
          'Bangalore East': [
            'Varthur Lake', 'Bellandur Lake', 'Agara Lake', 'Madivala Lake'
          ],
          'Bangalore West': [
            'Hebbal Lake', 'Sankey Tank', 'Lalbagh Pond'
          ],
          'Bangalore North': [
            'Hesaraghatta Lake', 'Yelahanka Lake', 'Rachenahalli Lake',
            'Jakkur Lake'
          ],
          'Bangalore South': [
            'Hulimavu Lake', 'Kaikondrahalli Lake', 'Talaghattapura Lake'
          ],
          'Yelahanka': ['Yelahanka Lake', 'Kogilu Lake', 'Jakkur Aerodrome Lake'],
          'Anekal': ['Hulimangala Lake', 'Marsur Lake'],
        }
      },
      'Bengaluru Rural': {
        'waterBodies': [
          'Arkavathi River', 'Hesaraghatta Reservoir', 'T.G. Halli Reservoir'
        ],
      },
      'Mysuru': {
        'waterBodies': [
          'Cauvery River', 'Kabini River', 'Krishna Raja Sagara',
          'Lingambudhi Lake'
        ],
      },
      'Mangaluru': {
        'waterBodies': [
          'Netravati River', 'Gurupura River', 'Phalguni River', 'Arabian Sea'
        ],
      },
      'Hubballi-Dharwad': {
        'waterBodies': [
          'Dharma River', 'Renuka Sagar', 'Unkal Lake', 'Tungabhadra River'
        ],
      },
      'Belagavi': {
        'waterBodies': [
          'Krishna River', 'Malaprabha River', 'Ghataprabha River'
        ],
      },
      'Shivamogga': {
        'waterBodies': [
          'Tunga River', 'Bhadra River', 'Bhadra Reservoir', 'Sharavathi River'
        ],
      },
      'Hassan': {
        'waterBodies': [
          'Hemavathi River', 'Yagachi River', 'Hemavathi Reservoir'
        ],
      },
      'Davanagere': {
        'waterBodies': [
          'Tungabhadra River', 'Bhadra River', 'Mayakonda Tank'
        ],
      },
      'Vijayapura': {
        'waterBodies': [
          'Krishna River', 'Doddahalla River', 'Almatti Dam'
        ],
      },
      'Ballari': {
        'waterBodies': [
          'Tungabhadra River', 'Hagari River', 'Harangi Dam'
        ],
      },
      'Tumakuru': {
        'waterBodies': [
          'Jayamangali River', 'Shimsha River', 'Pavagada Lake'
        ],
      },
      'Kodagu': {
        'waterBodies': [
          'Cauvery River (Source)', 'Kabini River', 'Harangi River',
          'Lakshmana Tirtha'
        ],
      },
      'Udupi': {
        'waterBodies': [
          'Sauparnika River', 'Swarna River', 'Arabian Sea', 'Souparnika Lake'
        ],
      },
      'Uttara Kannada': {
        'waterBodies': [
          'Sharavathi River', 'Bedthi River', 'Kalinadi River', 'Arabian Sea'
        ],
      },
      'Dakshina Kannada': {
        'waterBodies': [
          'Netravati River', 'Payaswini River', 'Gurpur River'
        ],
      },
      'Chamarajanagara': {
        'waterBodies': [
          'Cauvery River', 'Kabini River', 'Suvarnavathi River'
        ],
      },
      'Mandya': {
        'waterBodies': [
          'Cauvery River', 'Shimsha River', 'Lokapavani River', 'Krishna Raja Sagara'
        ],
      },
      'Ramanagara': {
        'waterBodies': [
          'Arkavathi River', 'Kumudvathi River', 'Kanva Reservoir'
        ],
      },
      'Chikkamagaluru': {
        'waterBodies': [
          'Bhadra River', 'Tunga River', 'Bhadra Reservoir'
        ],
      },
      'Kolar': {
        'waterBodies': ['Palar River', 'Bethamangala Lake', 'Kolar Lake'],
      },
      'Chikkaballapur': {
        'waterBodies': ['Palar River', 'Pennar River', 'Manchanabele Dam'],
      },
      'Raichur': {
        'waterBodies': [
          'Krishna River', 'Tungabhadra River', 'Bheema River'
        ],
      },
      'Koppal': {
        'waterBodies': ['Tungabhadra River', 'Hagari River'],
      },
      'Gadag': {
        'waterBodies': ['Malaprabha River', 'Tungabhadra River'],
      },
      'Kalaburagi': {
        'waterBodies': ['Bhima River', 'Kagina River'],
      },
      'Bidar': {
        'waterBodies': ['Manjra River', 'Karanja River', 'Bidar Lake'],
      },
      'Yadgir': {
        'waterBodies': ['Bhima River', 'Kagina River'],
      },
      'Chitradurga': {
        'waterBodies': [
          'Vedavathi River', 'Tungabhadra River', 'Vani Vilasa Sagara'
        ],
      },
      'Haveri': {
        'waterBodies': ['Tungabhadra River', 'Varada River', 'Dharma River'],
      },
    },

    // ── DELHI ────────────────────────────────────────────────────────────────
    'Delhi': {
      'Central Delhi': {
        'waterBodies': ['Yamuna River', 'Ring Road Canal', 'Delhi Gate Tank'],
      },
      'New Delhi': {
        'waterBodies': ['Yamuna River', 'Najafgarh Lake', 'Sanjay Lake'],
      },
      'North Delhi': {
        'waterBodies': ['Yamuna River', 'Munak Canal', 'Bakoli Drain'],
      },
      'North East Delhi': {
        'waterBodies': ['Yamuna River', 'Hindon River', 'Ghazipur Drain'],
      },
      'North West Delhi': {
        'waterBodies': ['Yamuna River', 'Rohini Lakes', 'Munak Canal'],
      },
      'South Delhi': {
        'waterBodies': ['Yamuna River', 'Najafgarh Lake', 'Hauz Khas Lake'],
      },
      'South East Delhi': {
        'waterBodies': ['Yamuna River', 'Agra Canal'],
      },
      'South West Delhi': {
        'waterBodies': ['Yamuna River', 'Najafgarh Jheel', 'Sultanpur Lake'],
      },
      'East Delhi': {
        'waterBodies': ['Yamuna River', 'Hindon River'],
      },
      'West Delhi': {
        'waterBodies': ['Yamuna River', 'Najafgarh Drain', 'Palam Lake'],
      },
      'Shahdara': {
        'waterBodies': ['Yamuna River', 'Hindon River'],
      },
    },

    // ── UTTAR PRADESH ────────────────────────────────────────────────────────
    'Uttar Pradesh': {
      'Lucknow': {
        'waterBodies': [
          'Gomti River', 'Kukrail River', 'Sharda Canal'
        ],
      },
      'Kanpur': {
        'waterBodies': ['Ganga River', 'Pandu River', 'Isan River'],
      },
      'Agra': {
        'waterBodies': ['Yamuna River', 'Chambal River'],
      },
      'Varanasi': {
        'waterBodies': ['Ganga River', 'Varuna River', 'Assi River'],
      },
      'Prayagraj': {
        'waterBodies': [
          'Ganga River', 'Yamuna River', 'Triveni Sangam', 'Tons River'
        ],
      },
      'Mathura': {
        'waterBodies': ['Yamuna River', 'Baldeo River'],
      },
      'Meerut': {
        'waterBodies': ['Hindon River', 'Kali River'],
      },
      'Ghaziabad': {
        'waterBodies': ['Hindon River', 'Yamuna River', 'Kali River'],
      },
      'Gautam Buddha Nagar (Noida)': {
        'waterBodies': [
          'Yamuna River', 'Hindon River', 'Okhla Bird Sanctuary Lake'
        ],
      },
      'Gorakhpur': {
        'waterBodies': ['Rapti River', 'Rohini River', 'Ami River'],
      },
      'Bareilly': {
        'waterBodies': ['Ramganga River', 'Deoha River'],
      },
      'Moradabad': {
        'waterBodies': ['Ramganga River', 'Nalhon River'],
      },
      'Saharanpur': {
        'waterBodies': ['Dhamola River', 'Yamuna River', 'Solani River'],
      },
      'Aligarh': {
        'waterBodies': ['Sengar River', 'Yamuna River'],
      },
      'Jhansi': {
        'waterBodies': ['Pahuj River', 'Betwa River'],
      },
      'Ayodhya': {
        'waterBodies': ['Saryu River', 'Ghaghara River'],
      },
      'Muzaffarnagar': {
        'waterBodies': [
          'Yamuna River', 'Kali River', 'Ganga Canal'
        ],
      },
      'Firozabad': {
        'waterBodies': ['Yamuna River', 'Sirsa River'],
      },
      'Sitapur': {
        'waterBodies': ['Ganga River', 'Sharda River', 'Chauka River'],
      },
      'Lakhimpur Kheri': {
        'waterBodies': ['Ghaghra River', 'Sharda River', 'Chauka River'],
      },
    },

    // ── WEST BENGAL ──────────────────────────────────────────────────────────
    'West Bengal': {
      'Kolkata': {
        'subDistricts': {
          'Kolkata North': [
            'Hooghly River', 'Adi Ganga', 'Baranagar Ghat Waters'
          ],
          'Kolkata South': [
            'Hooghly River', 'Adi Ganga', 'Tolly Canal', 'Nalban Wetlands'
          ],
          'Kolkata Central': ['Hooghly River', 'Circular Canal'],
          'Howrah': [
            'Hooghly River', 'Shibpur Wetland', 'Santragachi Lake'
          ],
          'Salt Lake (Bidhannagar)': [
            'East Kolkata Wetlands', 'Lake Town Water Bodies', 'Kestopur Canal'
          ],
          'New Town (Rajarhat)': [
            'New Town Lake', 'East Kolkata Wetlands', 'Chakberia Lake'
          ],
          'Jadavpur': ['Tolly Canal', 'Adi Ganga'],
        }
      },
      'Darjeeling': {
        'waterBodies': [
          'Teesta River', 'Relli River', 'Mirik Lake', 'Senchal Lake'
        ],
      },
      'North 24 Parganas': {
        'waterBodies': [
          'Hooghly River', 'Ichhamati River', 'Bidyadhari River'
        ],
      },
      'South 24 Parganas': {
        'waterBodies': [
          'Hooghly River', 'Muriganga River', 'Saptamukhi River',
          'Matla River', 'Sundarbans'
        ],
      },
      'Purba Bardhaman': {
        'waterBodies': ['Damodar River', 'Ajay River', 'Kunur River'],
      },
      'Paschim Bardhaman': {
        'waterBodies': ['Damodar River', 'Barakar River'],
      },
      'Murshidabad': {
        'waterBodies': [
          'Bhagirathi River', 'Padma River', 'Mayurakshi River'
        ],
      },
      'Nadia': {
        'waterBodies': ['Bhagirathi River', 'Jalangi River', 'Churni River'],
      },
      'Hooghly': {
        'waterBodies': [
          'Hooghly River', 'Saraswati River', 'Damodar River'
        ],
      },
      'Howrah': {
        'waterBodies': [
          'Hooghly River', 'Rupnarayan River', 'Damodar River'
        ],
      },
      'Malda': {
        'waterBodies': ['Ganga River', 'Mahananda River', 'Fulhar River'],
      },
      'Jalpaiguri': {
        'waterBodies': ['Teesta River', 'Jaldhaka River', 'Torsa River'],
      },
      'Cooch Behar': {
        'waterBodies': ['Torsa River', 'Jaldhaka River', 'Raidak River'],
      },
      'Purulia': {
        'waterBodies': ['Kasai River', 'Subarnarekha River', 'Kangsabati River'],
      },
      'Bankura': {
        'waterBodies': [
          'Damodar River', 'Kangsabati River', 'Dwarakeswar River'
        ],
      },
      'Birbhum': {
        'waterBodies': [
          'Mayurakshi River', 'Brahmani River', 'Kopai River',
          'Bakreswar River'
        ],
      },
      'Medinipur (East)': {
        'waterBodies': [
          'Rupnarayan River', 'Rasulpur River', 'Bay of Bengal'
        ],
      },
      'Medinipur (West)': {
        'waterBodies': ['Kasai River', 'Silabati River', 'Kangsabati River'],
      },
      'Alipurduar': {
        'waterBodies': ['Torsa River', 'Jayanti River', 'Raidak River'],
      },
    },

    // ── RAJASTHAN ────────────────────────────────────────────────────────────
    'Rajasthan': {
      'Jaipur': {
        'subDistricts': {
          'Jaipur North': [
            'Mansagar Lake', 'Ramgarh Reservoir', 'Nahargarh Lake'
          ],
          'Jaipur South': ['Amanishah Nallah', 'Dravyavati River'],
          'Jaipur East': ['Chandlai Lake', 'Ramgarh Reservoir'],
          'Sanganer': ['Dravyavati River', 'Ramgarh Lake'],
          'Phulera': ['Sambhar Salt Lake'],
          'Chomu': ['Sambhar Lake', 'Dhund Bhandsari River'],
        }
      },
      'Jodhpur': {
        'waterBodies': ['Kaylana Lake', 'Balsamand Lake', 'Takhat Sagar Lake'],
      },
      'Udaipur': {
        'waterBodies': [
          'Pichola Lake', 'Fateh Sagar Lake', 'Badi Lake',
          'Jaisamand Lake', 'Berach River'
        ],
      },
      'Ajmer': {
        'waterBodies': [
          'Ana Sagar Lake', 'Foy Sagar Lake', 'Pushkar Lake', 'Luni River'
        ],
      },
      'Kota': {
        'waterBodies': ['Chambal River', 'Kota Barrage', 'Kishore Sagar Lake'],
      },
      'Bikaner': {
        'waterBodies': ['Gajner Lake', 'Kolayat Lake', 'Indira Gandhi Canal'],
      },
      'Bharatpur': {
        'waterBodies': [
          'Yamuna River', 'Gambhir River', 'Keoladeo Ghana Lake'
        ],
      },
      'Alwar': {
        'waterBodies': ['Siliserh Lake', 'Sariska Lake', 'Arvari River'],
      },
      'Chittorgarh': {
        'waterBodies': [
          'Berach River', 'Gambhiri River', 'Rana Pratap Sagar'
        ],
      },
      'Banswara': {
        'waterBodies': ['Mahi River', 'Som River', 'Mahi Bajaj Sagar'],
      },
      'Pali': {
        'waterBodies': ['Luni River', 'Jawai Dam', 'Hemawas Dam'],
      },
      'Dungarpur': {
        'waterBodies': ['Mahi River', 'Som River', 'Gaib Sagar Lake'],
      },
      'Tonk': {
        'waterBodies': ['Banas River', 'Bisalpur Dam', 'Mashi River'],
      },
      'Bundi': {
        'waterBodies': ['Chambal River', 'Mej River', 'Nawal Sagar Lake'],
      },
      'Sawai Madhopur': {
        'waterBodies': ['Chambal River', 'Banas River', 'Rani Tal'],
      },
      'Jhalawar': {
        'waterBodies': [
          'Chambal River', 'Kali Sindh River', 'Gagron Lake'
        ],
      },
      'Sikar': {
        'waterBodies': ['Kantali River', 'Sabi River'],
      },
      'Barmer': {
        'waterBodies': ['Luni River', 'Khabber Lake'],
      },
      'Nagaur': {
        'waterBodies': ['Luni River', 'Meja Reservoir', 'Nagaur Lake'],
      },
      'Sirohi': {
        'waterBodies': ['Jawai River', 'Banas River', 'Nakki Lake'],
      },
      'Hanumangarh': {
        'waterBodies': [
          'Ghaggar River', 'Gang Canal', 'Indira Gandhi Canal'
        ],
      },
      'Ganganagar': {
        'waterBodies': ['Ghaggar River', 'Gang Canal'],
      },
    },

    // ── GUJARAT ──────────────────────────────────────────────────────────────
    'Gujarat': {
      'Ahmedabad': {
        'subDistricts': {
          'Ahmedabad City East': [
            'Sabarmati River', 'Kankaria Lake', 'Vastrapur Lake'
          ],
          'Ahmedabad City West': ['Sabarmati River', 'Chandola Lake'],
          'Dholka': ['Nalsarovar Lake', 'Nal Lake'],
          'Sanand': ['Sabarmati River', 'Rupen River'],
          'Viramgam': ['Nalsarovar Lake', 'Rupen River'],
          'Bavla': ['Watrak River', 'Sabarmati River'],
        }
      },
      'Surat': {
        'waterBodies': ['Tapi River', 'Mindhola River', 'Arabian Sea Coast'],
      },
      'Vadodara': {
        'waterBodies': ['Vishwamitri River', 'Mahi River', 'Dhadhar River'],
      },
      'Rajkot': {
        'waterBodies': ['Aji River', 'Nyari River', 'Lalpari Lake', 'Randarda Lake'],
      },
      'Bhavnagar': {
        'waterBodies': ['Shetrungi River', 'Kansla River', 'Gulf of Khambhat'],
      },
      'Gandhinagar': {
        'waterBodies': ['Sabarmati River', 'Kalol River'],
      },
      'Jamnagar': {
        'waterBodies': ['Nagmati River', 'Ranmal Lake', 'Arabian Sea'],
      },
      'Junagadh': {
        'waterBodies': ['Kalva River', 'Ojat River', 'Hamirsar Lake'],
      },
      'Anand': {
        'waterBodies': ['Mahi River', 'Shedi River'],
      },
      'Kheda': {
        'waterBodies': ['Mahi River', 'Shedi River', 'Watrak River'],
      },
      'Panchmahal': {
        'waterBodies': ['Mahi River', 'Panam Dam', 'Kadana Dam'],
      },
      'Narmada': {
        'waterBodies': [
          'Narmada River', 'Sardar Sarovar Dam', 'Karjan Dam'
        ],
      },
      'Bharuch': {
        'waterBodies': [
          'Narmada River', 'Mahi River', 'Gulf of Khambhat'
        ],
      },
      'Valsad': {
        'waterBodies': [
          'Damanganga River', 'Auranga River', 'Kolak River'
        ],
      },
      'Navsari': {
        'waterBodies': ['Purna River', 'Ambika River', 'Mindhola River'],
      },
      'Tapi': {
        'waterBodies': ['Tapi River', 'Purna River'],
      },
      'Kutch': {
        'waterBodies': ['Rukmavati River', 'Hamirsar Lake', 'Rann of Kutch'],
      },
      'Banaskantha': {
        'waterBodies': ['Banas River', 'Rupen River', 'Danta Lake'],
      },
      'Mehsana': {
        'waterBodies': ['Rupen River', 'Saraswati River'],
      },
      'Patan': {
        'waterBodies': ['Saraswati River', 'Rupen River', 'Rani-ki-Vav'],
      },
      'Morbi': {
        'waterBodies': ['Machhu River', 'Morbi Dam'],
      },
      'Gir Somnath': {
        'waterBodies': ['Hiran River', 'Shetrungi River'],
      },
      'Surendranagar': {
        'waterBodies': ['Bhogavo River', 'Fulzar River', 'Wadhwan Lake'],
      },
    },

    // ── MADHYA PRADESH ───────────────────────────────────────────────────────
    'Madhya Pradesh': {
      'Bhopal': {
        'waterBodies': [
          'Upper Lake (Bhopal)', 'Lower Lake (Bhopal)',
          'Halali River', 'Betwa River', 'Kaliasot River'
        ],
      },
      'Indore': {
        'waterBodies': [
          'Shipra River', 'Khan River', 'Yashwant Sagar', 'Sirpur Lake'
        ],
      },
      'Gwalior': {
        'waterBodies': [
          'Chambal River', 'Sank River', 'Tigra Dam', 'Gwalior Lake'
        ],
      },
      'Jabalpur': {
        'waterBodies': [
          'Narmada River', 'Wainganga River', 'Bhedaghat Lake'
        ],
      },
      'Ujjain': {
        'waterBodies': ['Shipra River', 'Khan River', 'Gambhir River'],
      },
      'Sagar': {
        'waterBodies': ['Sagar Lake', 'Bina River', 'Dhasan River'],
      },
      'Rewa': {
        'waterBodies': ['Tons River', 'Tamsa River', 'Beehar River'],
      },
      'Satna': {
        'waterBodies': ['Ken River', 'Tamsa River', 'Satna River'],
      },
      'Morena': {
        'waterBodies': ['Chambal River', 'Kwari River', 'Asan River'],
      },
      'Shivpuri': {
        'waterBodies': [
          'Betwa River', 'Parvati River', 'Madhav Sagar Lake'
        ],
      },
      'Chhindwara': {
        'waterBodies': ['Pench River', 'Sher River', 'Kanhan River'],
      },
      'Hoshangabad': {
        'waterBodies': [
          'Narmada River', 'Denwa River', 'Tawa River', 'Tawa Reservoir'
        ],
      },
      'Khandwa': {
        'waterBodies': [
          'Narmada River', 'Tapti River', 'Indira Sagar'
        ],
      },
      'Khargone': {
        'waterBodies': ['Narmada River', 'Dhud River'],
      },
      'Burhanpur': {
        'waterBodies': ['Tapti River', 'Utawali River'],
      },
      'Dewas': {
        'waterBodies': ['Shipra River', 'Chambal River'],
      },
      'Mandsaur': {
        'waterBodies': ['Chambal River', 'Sivna River', 'Gandhi Sagar'],
      },
      'Ratlam': {
        'waterBodies': ['Chambal River', 'Mahi River'],
      },
      'Jhabua': {
        'waterBodies': ['Mahi River', 'Anas River'],
      },
      'Dhar': {
        'waterBodies': ['Narmada River', 'Mahi River', 'Machak River'],
      },
      'Barwani': {
        'waterBodies': ['Narmada River', 'Deb River'],
      },
      'Balaghat': {
        'waterBodies': ['Wainganga River', 'Bawanthadi River'],
      },
      'Mandla': {
        'waterBodies': ['Narmada River', 'Burhner River', 'Mandla Lake'],
      },
      'Singrauli': {
        'waterBodies': ['Rihand River', 'Govind Ballabh Pant Sagar'],
      },
      'Shahdol': {
        'waterBodies': ['Son River', 'Johilla River'],
      },
      'Anuppur': {
        'waterBodies': [
          'Narmada River (Source)', 'Son River', 'Johilla River'
        ],
      },
      'Panna': {
        'waterBodies': ['Ken River', 'Panna River'],
      },
      'Chhatarpur': {
        'waterBodies': ['Ken River', 'Kathajana River'],
      },
      'Tikamgarh': {
        'waterBodies': ['Betwa River', 'Jamni River'],
      },
    },

    // ── KERALA ───────────────────────────────────────────────────────────────
    'Kerala': {
      'Thiruvananthapuram': {
        'waterBodies': [
          'Karamana River', 'Killi River', 'Vellayani Lake',
          'Parvathy Puthanar Canal'
        ],
      },
      'Ernakulam': {
        'subDistricts': {
          'Kochi City': [
            'Vembanad Lake', 'Periyar River',
            'Arabian Sea', 'Cochin Backwaters'
          ],
          'Aluva': ['Periyar River', 'Chalakudy River'],
          'Muvattupuzha': ['Muvattupuzha River', 'Periyar River'],
          'Angamaly': ['Periyar River', 'Chalakudy River'],
          'Paravur': ['Vembanad Lake', 'Periyar River'],
          'Kothamangalam': ['Muvattupuzha River', 'Periyar River'],
        }
      },
      'Kozhikode': {
        'waterBodies': [
          'Chaliyar River', 'Kozhikode Backwaters',
          'Arabian Sea', 'Kadalundi River'
        ],
      },
      'Thrissur': {
        'waterBodies': [
          'Chalakudy River', 'Bharathapuzha River', 'Karuvannur River'
        ],
      },
      'Palakkad': {
        'waterBodies': [
          'Bharathapuzha River', 'Walayar River',
          'Malampuzha Dam', 'Silent Valley River'
        ],
      },
      'Malappuram': {
        'waterBodies': [
          'Bharathapuzha River', 'Chaliyar River', 'Kadalundi River'
        ],
      },
      'Kannur': {
        'waterBodies': [
          'Valapattanam River', 'Anjarakandy River', 'Parassinikadavu River'
        ],
      },
      'Kasaragod': {
        'waterBodies': ['Chandragiri River', 'Payaswini River', 'Kuppam River'],
      },
      'Kollam': {
        'waterBodies': [
          'Kallada River', 'Ithikkara River', 'Ashtamudi Lake', 'Pamba River'
        ],
      },
      'Alappuzha': {
        'waterBodies': [
          'Vembanad Lake', 'Pamba River',
          'Manimala River', 'Achankovil River'
        ],
      },
      'Pathanamthitta': {
        'waterBodies': ['Pamba River', 'Achankovil River', 'Manimala River'],
      },
      'Kottayam': {
        'waterBodies': [
          'Meenachil River', 'Manimala River',
          'Vembanad Lake', 'Pamba River'
        ],
      },
      'Idukki': {
        'waterBodies': [
          'Periyar River', 'Idukki Reservoir', 'Pambar River'
        ],
      },
      'Wayanad': {
        'waterBodies': ['Kabani River', 'Banasura Sagar', 'Panamaram River'],
      },
    },

    // ── TELANGANA ────────────────────────────────────────────────────────────
    'Telangana': {
      'Hyderabad': {
        'subDistricts': {
          'Hyderabad Central': ['Hussain Sagar Lake', 'Musi River'],
          'Hyderabad East': ['Himayat Sagar', 'Osman Sagar', 'Musi River'],
          'Secunderabad': ['Hussain Sagar Lake', 'Trimulgherry Lake'],
          'Cyberabad (Madhapur)': [
            'Durgam Cheruvu', 'Saroornagar Lake', 'Banjara Lake'
          ],
          'Kukatpally': ['Patancheru Lake', 'Hussain Sagar Lake'],
          'Uppal': ['Nagole Lake', 'Musi River'],
          'LB Nagar': ['Himayat Sagar', 'Musi River'],
          'Medchal': ['Osmansagar', 'Durgam Cheruvu', 'Isnapur Lake'],
        }
      },
      'Warangal': {
        'waterBodies': [
          'Bhadrakali Lake', 'Pakhal Lake', 'Ramappa Lake', 'Manair River'
        ],
      },
      'Nizamabad': {
        'waterBodies': [
          'Godavari River', 'Sriramsagar Dam', 'Nizamsagar Dam'
        ],
      },
      'Karimnagar': {
        'waterBodies': [
          'Godavari River', 'Manair River', 'Lower Manair Dam'
        ],
      },
      'Khammam': {
        'waterBodies': [
          'Krishna River', 'Godavari River', 'Kinnerasani River'
        ],
      },
      'Nalgonda': {
        'waterBodies': [
          'Krishna River', 'Nagarjuna Sagar', 'Musi River'
        ],
      },
      'Mahbubnagar': {
        'waterBodies': ['Krishna River', 'Tungabhadra River', 'Jurala Dam'],
      },
      'Medak': {
        'waterBodies': [
          'Godavari River', 'Manjira River', 'Singur Dam', 'Nizamsagar'
        ],
      },
      'Adilabad': {
        'waterBodies': [
          'Godavari River', 'Wardha River', 'Penganga River', 'Pranhita River'
        ],
      },
      'Rangareddy': {
        'waterBodies': [
          'Krishna River', 'Musi River', 'Osman Sagar', 'Himayat Sagar'
        ],
      },
    },

    // ── ANDHRA PRADESH ───────────────────────────────────────────────────────
    'Andhra Pradesh': {
      'Visakhapatnam': {
        'subDistricts': {
          'Visakhapatnam City': [
            'Meghadrigedda Reservoir', 'Gosthani River', 'Bay of Bengal'
          ],
          'Bheemunipatnam': ['Sarada River', 'Bay of Bengal'],
          'Anakapalle': ['Thandava River', 'Gosthani River'],
          'Paderu': ['Sabari River', 'Sileru River'],
        }
      },
      'Vijayawada': {
        'waterBodies': [
          'Krishna River', 'Budameru River',
          'Prakasam Barrage', 'Kolleru Lake'
        ],
      },
      'Guntur': {
        'waterBodies': [
          'Krishna River', 'Gundlakamma River', 'Nagarjuna Sagar'
        ],
      },
      'Tirupati': {
        'waterBodies': [
          'Swarnamukhi River', 'Arani River', 'Tirupati Pushkarani'
        ],
      },
      'Kurnool': {
        'waterBodies': [
          'Tungabhadra River', 'Krishna River', 'Handri River'
        ],
      },
      'Nellore': {
        'waterBodies': ['Pennar River', 'Swarnamukhi River', 'Somasila Dam'],
      },
      'Kadapa': {
        'waterBodies': ['Pennar River', 'Chitravathi River', 'Galeru River'],
      },
      'Anantapur': {
        'waterBodies': [
          'Tungabhadra River', 'Vedavathi River', 'Hagari River'
        ],
      },
      'Chittoor': {
        'waterBodies': ['Palar River', 'Swarnamukhi River', 'Kalyani Dam'],
      },
      'East Godavari': {
        'waterBodies': ['Godavari River', 'Bay of Bengal', 'Pampa River'],
      },
      'West Godavari': {
        'waterBodies': ['Godavari River', 'Krishna River', 'Kolleru Lake'],
      },
      'Krishna': {
        'waterBodies': ['Krishna River', 'Kolleru Lake', 'Bandar Canal'],
      },
      'Prakasam': {
        'waterBodies': [
          'Krishna River', 'Gundlakamma River', 'Pennar River'
        ],
      },
    },

    // ── BIHAR ────────────────────────────────────────────────────────────────
    'Bihar': {
      'Patna': {
        'waterBodies': [
          'Ganga River', 'Sone River', 'Punpun River', 'Gandak River'
        ],
      },
      'Gaya': {
        'waterBodies': ['Falgu River', 'Mohane River'],
      },
      'Bhagalpur': {
        'waterBodies': ['Ganga River', 'Chandan River', 'Kosi River'],
      },
      'Muzaffarpur': {
        'waterBodies': ['Gandak River', 'Burhi Gandak River', 'Bagmati River'],
      },
      'Darbhanga': {
        'waterBodies': ['Bagmati River', 'Kamla River', 'Balan River'],
      },
      'Purnia': {
        'waterBodies': ['Kosi River', 'Mahananda River'],
      },
      'Begusarai': {
        'waterBodies': ['Ganga River', 'Burhi Gandak River', 'Kabar Lake'],
      },
      'Vaishali': {
        'waterBodies': ['Ganga River', 'Gandak River', 'Burhi Gandak River'],
      },
      'Saran': {
        'waterBodies': ['Ganga River', 'Ghaghra River', 'Gandak River'],
      },
      'Sitamarhi': {
        'waterBodies': [
          'Bagmati River', 'Lakhandei River', 'Lalbakaiya River'
        ],
      },
      'Madhubani': {
        'waterBodies': ['Kamla River', 'Bagmati River', 'Adhwara River'],
      },
      'East Champaran (Motihari)': {
        'waterBodies': ['Gandak River', 'Burhi Gandak River'],
      },
      'West Champaran (Bettiah)': {
        'waterBodies': ['Gandak River', 'Burhi Gandak River'],
      },
    },

    // ── JHARKHAND ────────────────────────────────────────────────────────────
    'Jharkhand': {
      'Ranchi': {
        'waterBodies': [
          'Subarnarekha River', 'Kanchi River', 'Rukka Dam',
          'Hatia Dam', 'Getalsud Dam'
        ],
      },
      'Dhanbad': {
        'waterBodies': ['Damodar River', 'Barakar River'],
      },
      'Jamshedpur (East Singhbhum)': {
        'waterBodies': ['Subarnarekha River', 'Kharkai River', 'Dimna Lake'],
      },
      'Bokaro': {
        'waterBodies': ['Damodar River', 'Bokaro River', 'Tenughat Dam'],
      },
      'Hazaribagh': {
        'waterBodies': ['Damodar River', 'Barakar River', 'Konar River'],
      },
      'Giridih': {
        'waterBodies': ['Usri River', 'Barakar River'],
      },
      'Deoghar': {
        'waterBodies': ['Mayurakshi River', 'Ajay River'],
      },
      'Palamu': {
        'waterBodies': ['North Koel River', 'Auranga River'],
      },
      'Gumla': {
        'waterBodies': ['South Koel River', 'Sankh River'],
      },
    },

    // ── CHHATTISGARH ─────────────────────────────────────────────────────────
    'Chhattisgarh': {
      'Raipur': {
        'waterBodies': [
          'Mahanadi River', 'Kharun River', 'Budha Talab', 'Telibandha Lake'
        ],
      },
      'Bilaspur': {
        'waterBodies': ['Arpa River', 'Sheonath River', 'Hasdeo River'],
      },
      'Durg': {
        'waterBodies': ['Sheonath River', 'Tandula Reservoir'],
      },
      'Raigarh': {
        'waterBodies': ['Mahanadi River', 'Mand River'],
      },
      'Korba': {
        'waterBodies': ['Hasdeo River', 'Minimath River'],
      },
      'Jagdalpur (Bastar)': {
        'waterBodies': ['Indravati River', 'Chitrakoot Falls'],
      },
      'Dhamtari': {
        'waterBodies': ['Mahanadi River', 'Pairi River', 'Gangrel Dam'],
      },
      'Ambikapur (Surguja)': {
        'waterBodies': ['Rihand River', 'Son River'],
      },
    },

    // ── ODISHA ───────────────────────────────────────────────────────────────
    'Odisha': {
      'Bhubaneswar (Khordha)': {
        'waterBodies': [
          'Kuakhai River', 'Bindusagar Lake', 'Lingaraj Pond',
          'Chandaka Lake'
        ],
      },
      'Cuttack': {
        'waterBodies': [
          'Mahanadi River', 'Kathajodi River', 'Kuakhai River'
        ],
      },
      'Puri': {
        'waterBodies': ['Bay of Bengal', 'Chilika Lake', 'Kushabhadra River'],
      },
      'Sundargarh (Rourkela)': {
        'waterBodies': ['Brahmani River', 'Koel River', 'Mandira Dam'],
      },
      'Sambalpur': {
        'waterBodies': [
          'Mahanadi River', 'Hirakud Reservoir', 'Ong River'
        ],
      },
      'Ganjam (Berhampur)': {
        'waterBodies': ['Rushikulya River', 'Chilika Lake', 'Bay of Bengal'],
      },
      'Balasore': {
        'waterBodies': [
          'Subarnarekha River', 'Budhabalanga River', 'Bay of Bengal'
        ],
      },
      'Koraput': {
        'waterBodies': ['Sabari River', 'Kolab River', 'Machkund River'],
      },
      'Kalahandi': {
        'waterBodies': ['Mahanadi River', 'Tel River', 'Indravati River'],
      },
      'Mayurbhanj': {
        'waterBodies': [
          'Subarnarekha River', 'Budhabalanga River', 'Baripada Lake'
        ],
      },
    },

    // ── ASSAM ────────────────────────────────────────────────────────────────
    'Assam': {
      'Guwahati (Kamrup Metro)': {
        'waterBodies': [
          'Brahmaputra River', 'Bharalu River',
          'Deepar Beel', 'Silsako Beel'
        ],
      },
      'Dibrugarh': {
        'waterBodies': ['Brahmaputra River', 'Dibru River', 'Lohit River'],
      },
      'Silchar (Cachar)': {
        'waterBodies': ['Barak River', 'Sonai River', 'Katakhal River'],
      },
      'Jorhat': {
        'waterBodies': ['Brahmaputra River', 'Bhogdoi River'],
      },
      'Nagaon': {
        'waterBodies': ['Brahmaputra River', 'Kolong River', 'Kapili River'],
      },
      'Sonitpur (Tezpur)': {
        'waterBodies': ['Brahmaputra River', 'Jia Bharali River'],
      },
      'Lakhimpur': {
        'waterBodies': ['Brahmaputra River', 'Subansiri River'],
      },
      'Kamrup': {
        'waterBodies': ['Brahmaputra River', 'Kulsi River', 'Manas River'],
      },
      'Dhubri': {
        'waterBodies': ['Brahmaputra River', 'Jinjiram River'],
      },
      'Bongaigaon': {
        'waterBodies': ['Brahmaputra River', 'Aie River'],
      },
      'Karimganj': {
        'waterBodies': ['Barak River', 'Kushiyara River'],
      },
    },

    // ── PUNJAB ───────────────────────────────────────────────────────────────
    'Punjab': {
      'Amritsar': {
        'waterBodies': [
          'Beas River', 'Golden Temple Sarovar', 'Rambagh Pond'
        ],
      },
      'Ludhiana': {
        'waterBodies': ['Sutlej River', 'Buddha Nallah'],
      },
      'Jalandhar': {
        'waterBodies': ['Beas River', 'Bein River'],
      },
      'Patiala': {
        'waterBodies': ['Ghaggar River', 'Sirhind Canal'],
      },
      'Gurdaspur': {
        'waterBodies': ['Beas River', 'Ravi River', 'Chakki River'],
      },
      'Mohali (SAS Nagar)': {
        'waterBodies': ['Ghaggar River', 'Sukhna Lake'],
      },
      'Bathinda': {
        'waterBodies': ['Ghaggar River', 'Sirhind Canal'],
      },
      'Firozpur': {
        'waterBodies': ['Sutlej River', 'Harika Wetland'],
      },
      'Hoshiarpur': {
        'waterBodies': ['Beas River', 'Sutlej River', 'Swan River'],
      },
      'Pathankot': {
        'waterBodies': ['Ravi River', 'Chakki River', 'Beas River'],
      },
      'Rupnagar': {
        'waterBodies': ['Sutlej River', 'Swan River'],
      },
      'Kapurthala': {
        'waterBodies': ['Beas River', 'Sutlej River'],
      },
      'Tarn Taran': {
        'waterBodies': ['Sutlej River', 'Beas River', 'Harika Wetland'],
      },
      'Sangrur': {
        'waterBodies': ['Ghaggar River'],
      },
      'Faridkot': {
        'waterBodies': ['Sutlej River', 'Sirhind Canal'],
      },
      'Moga': {
        'waterBodies': ['Sutlej River'],
      },
      'Muktsar': {
        'waterBodies': ['Ghaggar River'],
      },
      'Mansa': {
        'waterBodies': ['Ghaggar River'],
      },
    },

    // ── HARYANA ──────────────────────────────────────────────────────────────
    'Haryana': {
      'Gurugram': {
        'waterBodies': [
          'Sahibi River', 'Najafgarh Lake', 'Ghata Lake'
        ],
      },
      'Faridabad': {
        'waterBodies': ['Yamuna River', 'Agra Canal', 'Badkhal Lake'],
      },
      'Ambala': {
        'waterBodies': ['Ghaggar River', 'Tangri River'],
      },
      'Karnal': {
        'waterBodies': [
          'Yamuna River', 'Western Yamuna Canal', 'Karnal Lake'
        ],
      },
      'Sonipat': {
        'waterBodies': ['Yamuna River', 'Krishnavati River'],
      },
      'Rohtak': {
        'waterBodies': ['Krishnavati River', 'Western Yamuna Canal'],
      },
      'Panipat': {
        'waterBodies': ['Yamuna River', 'Western Yamuna Canal'],
      },
      'Hisar': {
        'waterBodies': ['Ghaggar River', 'Bhindawas Lake'],
      },
      'Yamunanagar': {
        'waterBodies': [
          'Yamuna River', 'Somb River', 'Hathnikund Barrage'
        ],
      },
      'Kurukshetra': {
        'waterBodies': [
          'Ghaggar River', 'Brahmasarovar Lake', 'Sannihit Sarovar'
        ],
      },
      'Panchkula': {
        'waterBodies': ['Ghaggar River', 'Markanda River'],
      },
      'Rewari': {
        'waterBodies': ['Sahibi River', 'Krishnavati River'],
      },
      'Palwal': {
        'waterBodies': ['Yamuna River', 'Agra Canal'],
      },
      'Mahendragarh': {
        'waterBodies': ['Dohan River', 'Krishnavati River'],
      },
      'Bhiwani': {
        'waterBodies': ['Krishnavati River', 'Tangri River'],
      },
      'Sirsa': {
        'waterBodies': ['Ghaggar River', 'Markanda River'],
      },
      'Jhajjar': {
        'waterBodies': ['Sahibi River', 'Najafgarh Lake'],
      },
      'Nuh (Mewat)': {
        'waterBodies': ['Sahibi River'],
      },
      'Fatehabad': {
        'waterBodies': ['Ghaggar River'],
      },
    },

    // ── HIMACHAL PRADESH ─────────────────────────────────────────────────────
    'Himachal Pradesh': {
      'Shimla': {
        'waterBodies': ['Giri River', 'Pabbar River', 'Chadwick Falls'],
      },
      'Kullu (Manali)': {
        'waterBodies': ['Beas River', 'Parvati River', 'Solang Nala'],
      },
      'Kangra (Dharamsala)': {
        'waterBodies': ['Beas River', 'Uhl River', 'Pong Dam'],
      },
      'Mandi': {
        'waterBodies': ['Beas River', 'Suketi River', 'Pandoh Dam'],
      },
      'Solan': {
        'waterBodies': ['Ghaggar River', 'Gambar River'],
      },
      'Hamirpur': {
        'waterBodies': ['Beas River', 'Seer Khad'],
      },
      'Una': {
        'waterBodies': ['Swan River', 'Beas River'],
      },
      'Bilaspur': {
        'waterBodies': ['Gobind Sagar Lake', 'Sutlej River'],
      },
      'Chamba': {
        'waterBodies': ['Ravi River', 'Budhil River', 'Chamera Dam'],
      },
      'Lahaul & Spiti': {
        'waterBodies': ['Spiti River', 'Chenab River', 'Chandra River'],
      },
      'Kinnaur': {
        'waterBodies': ['Sutlej River', 'Spiti River', 'Baspa River'],
      },
      'Sirmaur': {
        'waterBodies': ['Giri River', 'Bata River'],
      },
    },

    // ── UTTARAKHAND ──────────────────────────────────────────────────────────
    'Uttarakhand': {
      'Dehradun': {
        'waterBodies': [
          'Ganga River', 'Rispana River', 'Bindal River', 'Song River'
        ],
      },
      'Haridwar': {
        'waterBodies': ['Ganga River', 'Kali River', 'Solani River'],
      },
      'Nainital': {
        'waterBodies': [
          'Naini Lake', 'Ramgarh Lake', 'Bhimtal Lake', 'Naukuchiatal Lake'
        ],
      },
      'Almora': {
        'waterBodies': ['Kosi River', 'Ramganga River', 'Suyal River'],
      },
      'Udham Singh Nagar (Rudrapur)': {
        'waterBodies': ['Gola River', 'Sharda River', 'Nanaksagar Reservoir'],
      },
      'Tehri Garhwal': {
        'waterBodies': ['Bhagirathi River', 'Bhilangana River', 'Tehri Dam'],
      },
      'Chamoli': {
        'waterBodies': [
          'Alaknanda River', 'Mandakini River',
          'Dhauli Ganga', 'Pindar River'
        ],
      },
      'Uttarkashi': {
        'waterBodies': ['Bhagirathi River', 'Jadh Ganga'],
      },
      'Pithoragarh': {
        'waterBodies': ['Kali River', 'Ramganga River', 'Dhauli Ganga River'],
      },
      'Pauri Garhwal': {
        'waterBodies': ['Alaknanda River', 'Nayar River'],
      },
      'Rudraprayag': {
        'waterBodies': ['Alaknanda River', 'Mandakini River'],
      },
      'Bageshwar': {
        'waterBodies': ['Saryu River', 'Gomti River'],
      },
    },

    // ── GOA ──────────────────────────────────────────────────────────────────
    'Goa': {
      'North Goa': {
        'waterBodies': [
          'Mandovi River', 'Chapora River', 'Aguada Bay', 'Arabian Sea'
        ],
      },
      'South Goa': {
        'waterBodies': [
          'Zuari River', 'Sal River', 'Betul Creek', 'Arabian Sea'
        ],
      },
    },

    // ── JAMMU & KASHMIR ──────────────────────────────────────────────────────
    'Jammu & Kashmir': {
      'Srinagar': {
        'waterBodies': [
          'Dal Lake', 'Wular Lake', 'Jhelum River', 'Nagin Lake',
          'Anchar Lake'
        ],
      },
      'Jammu': {
        'waterBodies': ['Tawi River', 'Chenab River', 'Surinsar Lake'],
      },
      'Baramulla': {
        'waterBodies': ['Jhelum River', 'Wular Lake', 'Pohru River'],
      },
      'Anantnag': {
        'waterBodies': ['Jhelum River', 'Veshaw River', 'Lidder River'],
      },
      'Pulwama': {
        'waterBodies': ['Jhelum River', 'Vishow River'],
      },
      'Kupwara': {
        'waterBodies': [
          'Pohru River', 'Jhelum River', 'Krishenganga River'
        ],
      },
      'Kathua': {
        'waterBodies': ['Ravi River', 'Ujh River'],
      },
      'Udhampur': {
        'waterBodies': ['Chenab River', 'Tawi River', 'Devika River'],
      },
      'Kishtwar': {
        'waterBodies': ['Chenab River', 'Marwah River'],
      },
    },

    // ── LADAKH ───────────────────────────────────────────────────────────────
    'Ladakh': {
      'Leh': {
        'waterBodies': [
          'Indus River', 'Pangong Lake', 'Tso Moriri Lake', 'Zanskar River'
        ],
      },
      'Kargil': {
        'waterBodies': ['Suru River', 'Dras River', 'Wakha River'],
      },
    },

    // ── NORTH-EAST STATES ────────────────────────────────────────────────────
    'Meghalaya': {
      'East Khasi Hills (Shillong)': {
        'waterBodies': ['Umkhrah River', 'Umiam Lake', 'Ward Lake'],
      },
      'West Garo Hills': {
        'waterBodies': ['Brahmaputra River', 'Simsang River', 'Someswari River'],
      },
      'East Jaintia Hills': {
        'waterBodies': ['Myntdu River', 'Lukha River', 'Dawki River'],
      },
      'West Khasi Hills': {
        'waterBodies': ['Kynshi River', 'Myntdu River'],
      },
      'Ri Bhoi': {
        'waterBodies': ['Umiam River', 'Umtrew River'],
      },
    },
    'Manipur': {
      'Imphal West': {
        'waterBodies': ['Loktak Lake', 'Nambul River', 'Iril River'],
      },
      'Imphal East': {
        'waterBodies': ['Imphal River', 'Iril River', 'Thoubal River'],
      },
      'Bishnupur': {
        'waterBodies': ['Loktak Lake', 'Ningthi River'],
      },
      'Thoubal': {
        'waterBodies': ['Thoubal River', 'Loktak Lake'],
      },
    },
    'Nagaland': {
      'Kohima': {
        'waterBodies': ['Dzuza River', 'Dhansiri River'],
      },
      'Dimapur': {
        'waterBodies': ['Dhansiri River', 'Doyang River'],
      },
      'Mokokchung': {
        'waterBodies': ['Milak River', 'Tizu River'],
      },
      'Mon': {
        'waterBodies': ['Tizu River', 'Lanye River'],
      },
    },
    'Mizoram': {
      'Aizawl': {
        'waterBodies': ['Tlawng River', 'Tuirial River'],
      },
      'Lunglei': {
        'waterBodies': ['Chhimtuipui River'],
      },
      'Champhai': {
        'waterBodies': ['Tiau River'],
      },
    },
    'Tripura': {
      'West Tripura': {
        'waterBodies': ['Gumti River', 'Haora River', 'Rudrasagar Lake'],
      },
      'South Tripura': {
        'waterBodies': ['Gomati River', 'Muhuri River'],
      },
      'North Tripura': {
        'waterBodies': ['Manu River', 'Dhalai River'],
      },
    },
    'Arunachal Pradesh': {
      'Papum Pare (Itanagar)': {
        'waterBodies': ['Dikrong River', 'Brahmaputra River'],
      },
      'East Siang': {
        'waterBodies': ['Siang River'],
      },
      'West Siang': {
        'waterBodies': ['Siang River', 'Tsangpo River'],
      },
      'Tawang': {
        'waterBodies': ['Tawang Chu River', 'Nyamjang Chu River'],
      },
      'Lohit': {
        'waterBodies': ['Lohit River', 'Brahmaputra River'],
      },
      'Changlang': {
        'waterBodies': ['Tirap River', 'Noa-Dihing River'],
      },
    },
    'Sikkim': {
      'East Sikkim': {
        'waterBodies': ['Teesta River', 'Rangpo Chu River', 'Tsomgo Lake'],
      },
      'North Sikkim': {
        'waterBodies': ['Teesta River', 'Lachen River', 'Gurudongmar Lake'],
      },
      'West Sikkim': {
        'waterBodies': ['Rangit River', 'Teesta River'],
      },
      'South Sikkim': {
        'waterBodies': ['Rangit River', 'Teesta River'],
      },
    },

    // ── UNION TERRITORIES ────────────────────────────────────────────────────
    'Puducherry': {
      'Puducherry': {
        'waterBodies': [
          'Arasalar River', 'Gingee River', 'Oussoudu Lake', 'Bay of Bengal'
        ],
      },
      'Karaikal': {
        'waterBodies': ['Cauvery River', 'Bay of Bengal'],
      },
      'Mahe': {
        'waterBodies': ['Mahe River', 'Arabian Sea'],
      },
      'Yanam': {
        'waterBodies': ['Godavari River', 'Bay of Bengal'],
      },
    },
    'Chandigarh': {
      'Chandigarh': {
        'waterBodies': ['Sukhna Lake', 'Patiali River', 'Ghaggar River'],
      },
    },
    'Andaman & Nicobar Islands': {
      'South Andaman': {
        'waterBodies': [
          'Port Blair Harbour', 'Andaman Sea', 'Corbyn\'s Cove Waters'
        ],
      },
      'North & Middle Andaman': {
        'waterBodies': ['Bay of Bengal', 'Andaman Sea', 'Baratang Creek'],
      },
      'Nicobar': {
        'waterBodies': ['Bay of Bengal', 'Indian Ocean'],
      },
    },
    'Lakshadweep': {
      'Kavaratti': {
        'waterBodies': ['Arabian Sea', 'Lagoon Waters'],
      },
      'Agatti': {
        'waterBodies': ['Arabian Sea', 'Atoll Lagoon'],
      },
    },
    'Dadra & Nagar Haveli and Daman & Diu': {
      'Daman': {
        'waterBodies': ['Daman Ganga River', 'Arabian Sea'],
      },
      'Diu': {
        'waterBodies': ['Arabian Sea', 'Gulf of Khambhat'],
      },
      'Dadra & Nagar Haveli': {
        'waterBodies': ['Daman Ganga River', 'Madhuban Dam'],
      },
    },
  };
}