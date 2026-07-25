import 'package:flutter/material.dart';
import 'dart:math';

/// Mapa de cadenas extraído directamente del recurso JSON / ARB (app_es.arb)
final Map<String, String> appStrings = {
  'appTitle': 'My Training Path',
  'hubTitle': 'Hub de Cálculo',
  'imcTitle': 'Calculadora IMC',
  'tmbTitle': 'Calculadora TMB',
  'mitTitle': 'Calculadora MIT',
  'goalTitle': 'Objetivo & Macros',
  'currentGoal': 'Objetivo Actual',
  'activeBadge': 'ACTIVO',
  'dailyTargetKcal': 'Calorías Diarias Objetivo',
  'macroDistribution': 'Distribución de Macronutrientes',
  'protein': 'Proteínas',
  'fats': 'Grasas (gr)',
  'carbs': 'Hidratos (hc)',
  'vitalEvaluations': 'Evaluaciones Vitales',
  'stepsCount': '4 Pasos',
  'readyBadge': 'Listo',
  'configBadge': 'Configurar',
  'yourWeight': 'Tu peso',
  'yourHeight': 'Tu altura',
  'requiredField': 'Obligatorio',
  'optionalField': 'Opcional',
  'yourAge': 'Tu edad',
  'sex': 'Sexo',
  'male': 'Hombre',
  'female': 'Mujer',
  'bodyFat': '% Graso',
  'activityLevel': 'Nivel de Actividad Física',
  'imcSummaryDesc': 'Índice de Masa Corporal',
  'tmbSummaryDesc': 'Tasa Metabólica Basal',
  'mitSummaryDesc': 'Gasto Energético Total',
  'imcHeader': 'IMC',
  'compositionHeader': 'Composición corporal',
  'underweight': 'Por debajo de 18.5',
  'underweightDesc': 'Inferior a lo normal',
  'normalWeight': 'Entre 18.5 y 24.9',
  'normalWeightDesc': 'Normal',
  'overweight': 'Entre 25.0 y 29.9',
  'overweightDesc': 'Superior a lo normal',
  'obesity': '30.0 en adelante',
  'obesityDesc': 'Obesidad',
  'saveAndReturn': 'GUARDAR Y VOLVER AL HUB',
  'continueToMIT': 'CONTINUAR A CALCULADORA MIT',
  'continueToGoal': 'CONTINUAR A SELECCIÓN DE OBJETIVO',
  'selectOrChangeGoal': 'SELECCIONAR O CAMBIAR OBJETIVO',
  'applyAndReturn': 'APLICAR Y VOLVER AL HUB',
  'autoSaveNote':
      'Tus macros se guardan automáticamente para el apartado de Dieta.',
  'gainMuscle': 'Ganar Masa Muscular (Superávit)',
  'loseFat': 'Bajar Grasa Corporal (Déficit)',
  'maintenance': 'Mantenimiento (Equilibrio)',
  'recommended': 'RECOMENDADO',
  'surplusMild': 'Superávit Ligero',
  'surplusMod': 'Superávit Moderado',
  'surplusAggr': 'Superávit Agresivo',
  'cutMild': 'Déficit Ligero',
  'cutMod': 'Déficit Moderado',
  'cutAggr': 'Déficit Agresivo',
  'normoCaloric': 'Normocalórica (Equilibrio)',
};

enum ScreenView { hub, imc, tmb, mit, goal }

enum GoalCategory { gain, cut, maintenance }

enum GoalLevel { ligero, moderado, agresivo }

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({Key? key}) : super(key: key);

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  ScreenView _currentScreen = ScreenView.hub;
  bool _isGoalConfigured = false;

  // Form Inputs State
  double _peso = 80.0;
  double _altura = 170.0;
  int _edad = 25;
  bool _isMale = true;
  double _grasaGraso = 0.0; // Opcional
  double _actividadFactor = 1.55; // Actividad moderada

  // Selected Goal State
  GoalCategory _selectedCategory = GoalCategory.gain;
  GoalLevel _selectedLevel = GoalLevel.ligero;
  String _goalTitle = 'Hipertrofia (Superávit Ligero)';

  // Controllers for text fields
  late TextEditingController _pesoController;
  late TextEditingController _alturaController;
  late TextEditingController _edadController;
  late TextEditingController _grasaController;

  @override
  void initState() {
    super.initState();
    _pesoController = TextEditingController(text: _peso.toStringAsFixed(0));
    _alturaController = TextEditingController(text: _altura.toStringAsFixed(0));
    _edadController = TextEditingController(text: _edad.toString());
    _grasaController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    _edadController.dispose();
    _grasaController.dispose();
    super.dispose();
  }

  // IMC Calculation
  double get _calculatedIMC {
    if (_altura <= 0) return 0;
    final alturaM = _altura / 100.0;
    return _peso / (alturaM * alturaM);
  }

  String get _imcCategory {
    final imc = _calculatedIMC;
    if (imc < 18.5) return appStrings['underweightDesc']!;
    if (imc <= 24.9) return appStrings['normalWeightDesc']!;
    if (imc <= 29.9) return appStrings['overweightDesc']!;
    return appStrings['obesityDesc']!;
  }

  // TMB Calculation (Mifflin-St Jeor / Katch-McArdle)
  double get _calculatedTMB {
    if (_peso <= 0 || _altura <= 0 || _edad <= 0) return 0;
    if (_grasaGraso > 0 && _grasaGraso < 60) {
      final masaMagra = _peso * (1.0 - (_grasaGraso / 100.0));
      return 370 + (21.6 * masaMagra);
    } else {
      if (_isMale) {
        return (10 * _peso) + (6.25 * _altura) - (5 * _edad) + 5;
      } else {
        return (10 * _peso) + (6.25 * _altura) - (5 * _edad) - 161;
      }
    }
  }

  // MIT Calculation
  double get _calculatedMIT => _calculatedTMB * _actividadFactor;

  // Active Goal Calorie & Macros Calculation
  Map<String, dynamic> _getGoalCalculations(GoalCategory cat, GoalLevel level) {
    final baseMit = _calculatedMIT;
    double targetKcal = baseMit;
    double protRatio = 2.0;
    double fatRatio = 0.9;
    String title = '';

    if (cat == GoalCategory.gain) {
      if (level == GoalLevel.ligero) {
        targetKcal += 250;
        protRatio = 2.0;
        fatRatio = 0.9;
        title = '${appStrings['surplusMild']!} (+250 kcal)';
      } else if (level == GoalLevel.moderado) {
        targetKcal += 400;
        protRatio = 2.0;
        fatRatio = 1.0;
        title = '${appStrings['surplusMod']!} (+400 kcal)';
      } else {
        targetKcal += 600;
        protRatio = 2.2;
        fatRatio = 1.0;
        title = '${appStrings['surplusAggr']!} (+600 kcal)';
      }
    } else if (cat == GoalCategory.cut) {
      if (level == GoalLevel.ligero) {
        targetKcal = max(1200, baseMit - 300);
        protRatio = 2.2;
        fatRatio = 0.8;
        title = '${appStrings['cutMild']!} (-300 kcal)';
      } else if (level == GoalLevel.moderado) {
        targetKcal = max(1200, baseMit - 500);
        protRatio = 2.2;
        fatRatio = 0.8;
        title = '${appStrings['cutMod']!} (-500 kcal)';
      } else {
        targetKcal = max(1200, baseMit - 700);
        protRatio = 2.3;
        fatRatio = 0.7;
        title = '${appStrings['cutAggr']!} (-700 kcal)';
      }
    } else {
      title = appStrings['normoCaloric']!;
    }

    final protG = (_peso * protRatio).round();
    final fatG = (_peso * fatRatio).round();
    final carbKcal = max(0.0, targetKcal - ((protG * 4) + (fatG * 9)));
    final carbG = (carbKcal / 4.0).round();

    return {
      'title': title,
      'targetKcal': targetKcal.round(),
      'protG': protG,
      'protRatio': '${protRatio.toStringAsFixed(1)}g / kg',
      'fatG': fatG,
      'fatRatio': '${fatRatio.toStringAsFixed(1)}g / kg',
      'carbG': carbG,
      'carbRatio': '${(carbG / _peso).toStringAsFixed(1)}g / kg',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 440),
            color: const Color(0xFF0F0F0F),
            child: Column(
              children: [
                // Header Bar
                _buildHeader(),

                // Dynamic Screen View Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildCurrentView(),
                  ),
                ),

                // Fixed Footer Action Button (Only on Hub)
                if (_currentScreen == ScreenView.hub) _buildHubFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    String title = appStrings['hubTitle']!;
    if (_currentScreen == ScreenView.imc) title = appStrings['imcTitle']!;
    if (_currentScreen == ScreenView.tmb) title = appStrings['tmbTitle']!;
    if (_currentScreen == ScreenView.mit) title = appStrings['mitTitle']!;
    if (_currentScreen == ScreenView.goal) title = appStrings['goalTitle']!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF0F0F0F),
        border: Border(bottom: BorderSide(color: Color(0xFF1F1F22))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (_currentScreen != ScreenView.hub) ...[
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFFEBC134)),
                  onPressed: () =>
                      setState(() => _currentScreen = ScreenView.hub),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(width: 12),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appStrings['appTitle']!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Color(0xFFEBC134),
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF3A3A3C)),
            ),
            child: const Icon(Icons.person, color: Color(0xFFEBC134), size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentView() {
    switch (_currentScreen) {
      case ScreenView.hub:
        return _buildHubView();
      case ScreenView.imc:
        return _buildIMCView();
      case ScreenView.tmb:
        return _buildTMBView();
      case ScreenView.mit:
        return _buildMITView();
      case ScreenView.goal:
        return _buildGoalView();
    }
  }

  Widget _buildHubView() {
    final activeData = _getGoalCalculations(_selectedCategory, _selectedLevel);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGoalSummaryCard(activeData),
        const SizedBox(height: 20),
        _buildEvaluationsHeader(),
        const SizedBox(height: 10),
        _buildEvaluationCards(),
      ],
    );
  }

  /// Construye la tarjeta superior con el objetivo actual, calorías y macros
  Widget _buildGoalSummaryCard(Map<String, dynamic> activeData) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2C2C2E)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Cabecera del Objetivo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBC134).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.track_changes,
                      color: Color(0xFFEBC134),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appStrings['currentGoal']!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _goalTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBC134),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  appStrings['activeBadge']!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 2. Bloque de Calorías Objetivo
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0F0F0F),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2A2A2D)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appStrings['dailyTargetKcal']!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF999999),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${activeData['targetKcal']}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFEBC134),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'kcal / día',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(
                  Icons.local_fire_department,
                  color: Color(0xFFEBC134),
                  size: 28,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 3. Cuadrícula de Macros
          Text(
            appStrings['macroDistribution']!,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF999999),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildMacroTile(
                appStrings['protein']!,
                '${activeData['protG']}g',
                activeData['protRatio'],
              ),
              const SizedBox(width: 8),
              _buildMacroTile(
                appStrings['fats']!,
                '${activeData['fatG']}g',
                activeData['fatRatio'],
              ),
              const SizedBox(width: 8),
              _buildMacroTile(
                appStrings['carbs']!,
                '${activeData['carbG']}g',
                activeData['carbRatio'],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Construye el título de la sección de evaluaciones
  Widget _buildEvaluationsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appStrings['vitalEvaluations']!,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF999999),
          ),
        ),
        Text(
          appStrings['stepsCount']!,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFFEBC134),
          ),
        ),
      ],
    );
  }

  /// Construye la lista de las 4 tarjetas de navegación (IMC, TMB, MIT, Objetivos)
  Widget _buildEvaluationCards() {
    return Column(
      children: [
        _buildNavCard(
          icon: Icons.monitor_weight_outlined,
          title: appStrings['imcTitle']!,
          subtitle:
              '${appStrings['imcSummaryDesc']!} (${_calculatedIMC.toStringAsFixed(1)})',
          badgeText: appStrings['readyBadge']!,
          onTap: () => setState(() => _currentScreen = ScreenView.imc),
        ),
        _buildNavCard(
          icon: Icons.bolt,
          title: appStrings['tmbTitle']!,
          subtitle:
              '${appStrings['tmbSummaryDesc']!} (${_calculatedTMB.round()} kcal)',
          badgeText: appStrings['readyBadge']!,
          onTap: () => setState(() => _currentScreen = ScreenView.tmb),
        ),
        _buildNavCard(
          icon: Icons.speed,
          title: appStrings['mitTitle']!,
          subtitle:
              '${appStrings['mitSummaryDesc']!} (${_calculatedMIT.round()} kcal)',
          badgeText: appStrings['readyBadge']!,
          onTap: () => setState(() => _currentScreen = ScreenView.mit),
        ),
        _buildNavCard(
          icon: Icons.track_changes,
          title: appStrings['goalTitle']!,
          subtitle: _isGoalConfigured
              ? _goalTitle
              : 'Requiere configuración inicial',
          badgeText: _isGoalConfigured
              ? appStrings['readyBadge']!
              : appStrings['configBadge']!,
          isConfig: !_isGoalConfigured,
          onTap: () => setState(() => _currentScreen = ScreenView.goal),
        ),
      ],
    );
  }

  Widget _buildMacroTile(String label, String value, String ratio) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF0F0F0F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2A2A2D)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF999999),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            Text(
              ratio,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFFEBC134),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String badgeText,
    bool isConfig = false,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2C2C2E)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF3A3A3C)),
                    ),
                    child: Icon(icon, color: const Color(0xFFEBC134), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isConfig
                                  ? const Color(0xFFEBC134).withOpacity(0.2)
                                  : const Color(0xFF10B981).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              badgeText,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: isConfig
                                    ? const Color(0xFFEBC134)
                                    : const Color(0xFF10B981),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF999999),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIMCView() {
    final imc = _calculatedIMC;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2C2C2E)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appStrings['imcTitle']!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: appStrings['yourWeight']!,
                      unit: 'kg',
                      controller: _pesoController,
                      onChanged: (val) {
                        setState(() => _peso = double.tryParse(val) ?? 0);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInputField(
                      label: appStrings['yourHeight']!,
                      unit: 'cm',
                      controller: _alturaController,
                      onChanged: (val) {
                        setState(() => _altura = double.tryParse(val) ?? 0);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2A2A2D)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Tu IMC es:',
                      style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
                    ),
                    Text(
                      imc.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFEBC134),
                      ),
                    ),
                    Text(
                      _imcCategory,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Classification Table
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2C2C2E)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Clasificación IMC',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF999999),
                ),
              ),
              const SizedBox(height: 10),
              Table(
                border: TableBorder.all(color: const Color(0xFF2A2A2D)),
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: Color(0xFF0F0F0F)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          appStrings['imcHeader']!,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          appStrings['compositionHeader']!,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildTableRow(
                    appStrings['underweight']!,
                    appStrings['underweightDesc']!,
                    imc < 18.5,
                  ),
                  _buildTableRow(
                    appStrings['normalWeight']!,
                    appStrings['normalWeightDesc']!,
                    imc >= 18.5 && imc <= 24.9,
                  ),
                  _buildTableRow(
                    appStrings['overweight']!,
                    appStrings['overweightDesc']!,
                    imc >= 25.0 && imc <= 29.9,
                  ),
                  _buildTableRow(
                    appStrings['obesity']!,
                    appStrings['obesityDesc']!,
                    imc >= 30.0,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          appStrings['saveAndReturn']!,
          () => setState(() {
            _isGoalConfigured = true; // <--- Cambiamos el estado aquí
            _currentScreen = ScreenView.hub;
          }),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String range, String label, bool isActive) {
    return TableRow(
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFEBC134) : Colors.transparent,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            range,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.black : Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.black : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTMBView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2C2C2E)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appStrings['tmbTitle']!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // Sex Selection Toggle
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isMale
                            ? const Color(0xFFEBC134).withOpacity(0.15)
                            : const Color(0xFF0F0F0F),
                        side: BorderSide(
                          color: _isMale
                              ? const Color(0xFFEBC134)
                              : const Color(0xFF3A3A3C),
                        ),
                      ),
                      onPressed: () => setState(() => _isMale = true),
                      icon: const Icon(
                        Icons.male,
                        color: Color(0xFFEBC134),
                        size: 16,
                      ),
                      label: Text(
                        appStrings['male']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !_isMale
                            ? const Color(0xFFEBC134).withOpacity(0.15)
                            : const Color(0xFF0F0F0F),
                        side: BorderSide(
                          color: !_isMale
                              ? const Color(0xFFEBC134)
                              : const Color(0xFF3A3A3C),
                        ),
                      ),
                      onPressed: () => setState(() => _isMale = false),
                      icon: const Icon(
                        Icons.female,
                        color: Color(0xFFEBC134),
                        size: 16,
                      ),
                      label: Text(
                        appStrings['female']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: appStrings['yourAge']!,
                      unit: 'años',
                      controller: _edadController,
                      onChanged: (val) =>
                          setState(() => _edad = int.tryParse(val) ?? 0),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField(
                      label: appStrings['yourWeight']!,
                      unit: 'kg',
                      controller: _pesoController,
                      onChanged: (val) =>
                          setState(() => _peso = double.tryParse(val) ?? 0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: '${appStrings['yourHeight']!} *',
                      unit: 'cm',
                      controller: _alturaController,
                      onChanged: (val) =>
                          setState(() => _altura = double.tryParse(val) ?? 0),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField(
                      label: appStrings['bodyFat']!,
                      unit: '%',
                      controller: _grasaController,
                      onChanged: (val) => setState(
                        () => _grasaGraso = double.tryParse(val) ?? 0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2A2A2D)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Tu TMB es de:',
                      style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
                    ),
                    Text(
                      '${_calculatedTMB.round()} kcal',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFEBC134),
                      ),
                    ),
                    Text(
                      _grasaGraso > 0
                          ? 'Fórmula: Katch-McArdle'
                          : 'Fórmula: Mifflin-St Jeor',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          appStrings['continueToMIT']!,
          () => setState(() => _currentScreen = ScreenView.mit),
        ),
      ],
    );
  }

  Widget _buildMITView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF2C2C2E)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appStrings['mitTitle']!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                appStrings['activityLevel']!,
                style: const TextStyle(fontSize: 11, color: Color(0xFF999999)),
              ),
              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF3A3A3C)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<double>(
                    value: _actividadFactor,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1C1C1E),
                    items: const [
                      DropdownMenuItem(
                        value: 1.2,
                        child: Text(
                          'Sedentario: poco o nada de ejercicio',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1.375,
                        child: Text(
                          'Actividad ligera: 1-3 días / semana',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1.55,
                        child: Text(
                          'Actividad moderada: 3-5 días / semana',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1.725,
                        child: Text(
                          'Actividad intensa: 6-7 días / semana',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1.9,
                        child: Text(
                          'Actividad muy intensa: ejercicio diario',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _actividadFactor = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2A2A2D)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Gasto Energético Total (MIT):',
                      style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
                    ),
                    Text(
                      '${_calculatedMIT.round()} kcal',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFEBC134),
                      ),
                    ),
                    Text(
                      '${_calculatedTMB.round()} kcal (TMB) × $_actividadFactor',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          appStrings['continueToGoal']!,
          () => setState(() => _currentScreen = ScreenView.goal),
        ),
      ],
    );
  }

  Widget _buildGoalView() {
    return Column(
      children: [
        // Category 1: Muscle Gain
        _buildGoalCategoryTile(
          title: appStrings['gainMuscle']!,
          icon: Icons.trending_up,
          category: GoalCategory.gain,
          levels: [GoalLevel.ligero, GoalLevel.moderado, GoalLevel.agresivo],
        ),
        const SizedBox(height: 12),

        // Category 2: Fat Loss
        _buildGoalCategoryTile(
          title: appStrings['loseFat']!,
          icon: Icons.trending_down,
          category: GoalCategory.cut,
          levels: [GoalLevel.ligero, GoalLevel.moderado, GoalLevel.agresivo],
        ),
        const SizedBox(height: 12),

        // Category 3: Maintenance
        _buildGoalCategoryTile(
          title: appStrings['maintenance']!,
          icon: Icons.balance,
          category: GoalCategory.maintenance,
          levels: [GoalLevel.ligero],
        ),

        const SizedBox(height: 20),
        _buildActionButton(
          appStrings['applyAndReturn']!,
          () => setState(() => _currentScreen = ScreenView.hub),
        ),
      ],
    );
  }

  Widget _buildGoalCategoryTile({
    required String title,
    required IconData icon,
    required GoalCategory category,
    required List<GoalLevel> levels,
  }) {
    final isCategoryActive = _selectedCategory == category;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2C2C2E)),
      ),
      child: ExpansionTile(
        initiallyExpanded: isCategoryActive,
        iconColor: const Color(0xFFEBC134),
        collapsedIconColor: const Color(0xFF999999),
        leading: Icon(icon, color: const Color(0xFFEBC134), size: 20),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        children: levels
            .map((lvl) => _buildGoalCardOption(category, lvl))
            .toList(),
      ),
    );
  }

  Widget _buildGoalCardOption(GoalCategory category, GoalLevel level) {
    final data = _getGoalCalculations(category, level);
    final isSelected = _selectedCategory == category && _selectedLevel == level;
    final isRecommended =
        level == GoalLevel.ligero && category != GoalCategory.maintenance;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = category;
            _selectedLevel = level;
            _goalTitle = data['title'];
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFEBC134)
                  : const Color(0xFF2A2A2D),
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['title'],
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (isRecommended)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBC134),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        appStrings['recommended']!,
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${data['targetKcal']} kcal / día',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEBC134),
                ),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  _buildSubMacroTile('PROT', '${data['protG']}g'),
                  const SizedBox(width: 6),
                  _buildSubMacroTile('GRASAS', '${data['fatG']}g'),
                  const SizedBox(width: 6),
                  _buildSubMacroTile('HC', '${data['carbG']}g'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubMacroTile(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 8, color: Color(0xFF999999)),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String unit,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF999999),
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: const Color(0xFFEBC134),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                unit,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 13, color: Colors.white),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            filled: true,
            fillColor: const Color(0xFF0F0F0F),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF3A3A3C)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFEBC134)),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEBC134),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildHubFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        border: Border(top: BorderSide(color: Color(0xFF2C2C2E))),
      ),
      child: Column(
        children: [
          _buildActionButton(
            appStrings['selectOrChangeGoal']!,
            () => setState(() => _currentScreen = ScreenView.goal),
          ),
          const SizedBox(height: 6),
          Text(
            appStrings['autoSaveNote']!,
            style: const TextStyle(fontSize: 10, color: Color(0xFF999999)),
          ),
        ],
      ),
    );
  }
}
