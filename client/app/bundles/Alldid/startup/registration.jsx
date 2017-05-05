import ReactOnRails from 'react-on-rails';

import Search from '../components/barbers/Search';
import SearchContainer from '../components/barbers/SearchContainer';
import FeaturedBarber from '../components/barbers/FeaturedBarber';
import ClientSidebar from '../components/barbers/ClientSidebar';
import Barber from '../components/barbers/Barber';
import BarberLink from '../components/barbers/BarberLink';
import Barbers from '../components/barbers/Barbers';
import BarberContainer from '../components/barbers/BarberContainer';
import BarberShowAttributes from '../components/barbers/BarberShowAttributes';
import UserStyles from '../components/forms/UserStyles';
import StyleTag from '../components/forms/StyleTag';
import UserServices from '../components/forms/UserServices';
import ServiceTag from '../components/forms/ServiceTag';
import Calendar from '../components/calendar/Calendar';

ReactOnRails.register({
	SearchContainer,
	Search,
	FeaturedBarber,
	ClientSidebar,
	Barber,
	BarberLink,
	Barbers,
	BarberContainer,
	BarberShowAttributes,
	UserStyles,
	StyleTag,
	UserServices,
	ServiceTag,
	Calendar
});
