import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/controller/booking_controller.dart';
import 'package:ticket_hub/model/booking/search_result.dart';
import 'package:ticket_hub/views/booking/widgets/result_container.dart';
import 'package:ticket_hub/views/tabs_screen/screens/home_page.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    super.key,
    required this.departureFrom,
    required this.arrivalTo,
    required this.selectedVehicleType,
  });

  final String departureFrom;
  final String arrivalTo;
  final MenuItem selectedVehicleType;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  MenuItem _currentVehicleType = MenuItem.all;

  @override
  void initState() {
    super.initState();
    _currentVehicleType = widget.selectedVehicleType;
  }

  List<Trip> _getFilteredTrips(TripResponse? searchResult) {
    if (searchResult == null) return [];

    switch (_currentVehicleType) {
      case MenuItem.all:
        return searchResult.allTrips;
      case MenuItem.hiace:
        return searchResult.hiaceTrips;
      case MenuItem.bus:
        return searchResult.busTrips;
      case MenuItem.train:
        return searchResult.trainTrips;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Result'),
      body: Consumer<BookingController>(
        builder: (context, bookingProvider, _) {
          if (bookingProvider.searchResult == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final results = _getFilteredTrips(bookingProvider.searchResult);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.departureFrom,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      SvgPicture.asset('assets/images/toooo.svg'),
                      Text(widget.arrivalTo,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Select your trip:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    _buildVehicleTypeSelector(context),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: results.isEmpty
                      ? Center(
                          child: Text(
                              'No ${_currentVehicleType.localizedName(context).toLowerCase()} trips available'))
                      : ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final result = results[index];
                            int minPrice = results.isEmpty
                                ? 0
                                : results
                                    .map((result) => result.price)
                                    .reduce((a, b) => a < b ? a : b);
                            return ResultContainer(
                              trip: result,
                              isCheapest: result.price == minPrice,
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVehicleTypeSelector(BuildContext context) {
    return DropdownButton<MenuItem>(
      value: _currentVehicleType,
      underline: Container(height: 2, color: orangeColor),
      onChanged: (MenuItem? newValue) {
        if (newValue != null) {
          setState(() {
            _currentVehicleType = newValue;
          });
        }
      },
      items: MenuItem.values.map<DropdownMenuItem<MenuItem>>((MenuItem value) {
        return DropdownMenuItem<MenuItem>(
          value: value,
          child: Text(value.localizedName(context)),
        );
      }).toList(),
    );
  }
}
