import axios from 'axios';
import { CarModel } from '../components/props';
import { CAR_API_BASE_URL } from './ConstantsCar';

interface ApiResponse {
    cars: CarModel[];
};

export const fetchGetCarData = async (id:number): Promise<CarModel | null> => {
    try {
        const response = await axios.get<ApiResponse>(CAR_API_BASE_URL);
        const carData = response.data.cars.find((car) => car.id === id) || null;
        return carData;
    } catch (error) {
        console.log("Erro ao buscar dados dos carros:", error);
        return null;
    }
};